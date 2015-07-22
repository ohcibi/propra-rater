require 'json'
require 'pry'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require './config/environments'

require './app/helpers'

require './app/models/rating'
require './app/models/pretest'
require './app/models/user'
require './lib/git'

git = Git.new "https://git.hhu.de/api/v3", ENV["gl_token"]

get "/teams" do
  protect!

  unless params["path"].nil?
    team = git.get_team params["path"]

    members = git.get_members_for(params["path"]).map do |member|
      pretest = Pretest.find_by member: member["id"]
      member["pretest"] = pretest.id unless pretest.nil?
      member
    end

    team["members"] = members.map { |m| m["id"] }

    gzip json teams: [team], members: members, ratings: Rating.all, pretests: Pretest.all
  else
    teams = git.teams.sort_by do |team|
      team["path"].gsub(/^team/, "").to_i 16
    end
    gzip json teams: teams
  end
end

get "/members" do
  protect!

  members = []
  git.teams.each do |team|
    members = members + git.get_members_for(team["path"])
  end

  members.sort_by! { |member| member["name"] }

  gzip json members: members, ratings: Rating.all, pretests: Pretest.all
end

get "/ratings" do
  protect!

  gzip json ratings: Rating.all
end

post "/ratings" do
  protect!

  body = request.body.read
  payload = JSON.parse body
  rating = Rating.new payload["rating"]
  rating.save
  json rating: rating
end

put "/ratings/:id" do
  protect!

  body = request.body.read
  payload = JSON.parse body
  json rating: Rating.update(params["id"], payload["rating"])
end

post "/pretests" do
  protect!

  body = request.body.read
  payload = JSON.parse body
  pretest = Pretest.new payload["pretest"]
  pretest.save
  json pretest: pretest
end

put "/pretests/:id" do
  protect!

  body = request.body.read
  payload = JSON.parse body
  json pretest: Pretest.update(params["id"], payload["pretest"])
end

delete "/ratings/:id" do
  protect!

  rating = Rating.find params["id"]
  rating.destroy!

  json rating: rating
end

get "/statistics" do
  protect!

  ratings = Rating.
    select(:id, :milestone, :member, :ko).
    group(:member).group(:milestone).
    group_by { |rating| rating.member }.
    values.as_json

  kosums = ratings.map do |member_ratings|
    member_ratings.map do |rating|

      otherkos = member_ratings.select do |r|
        r["milestone"] < rating["milestone"]
      end.map { |r| r["ko"] }

      kosum = otherkos.select { |r| r >= 0 }.reduce(:+).to_i

      kosum += rating["ko"] unless rating["ko"] < 0

      {
        milestone: rating["milestone"],
        kosum: kosum,
        failed: ([rating["ko"]] + otherkos).include?(-1)
      }
    end
  end

  good = [0]*12
  let4 = [0]*12
  get5 = [0]*12
  fa1l = (1..12).map do |ms|
    Rating.where("milestone <= ?", ms).where(ko: -1).count
  end

  kosums.each do |sums|
    sums.each do |sum|
      unless sum[:failed]
        if (sum[:milestone] - sum[:kosum]) < 2
          good[sum[:milestone] - 1] += 1
        elsif (sum[:milestone] - sum[:kosum]) < 4
          let4[sum[:milestone] - 1] += 1
        else
          get5[sum[:milestone] - 1] += 1
        end
      end
    end
  end

  json({
    active: {good: good, let4: let4, get5: get5, fail: fa1l },
    ratings: Rating.all
  })
end

post "/sessions" do
  body = request.body.read
  payload = JSON.parse body
  session = payload["session"]

  begin
    if authenticate? session["ident"], session["password"]
      json session: { token: authenticate!(session["ident"]) }
    else
      error401 message: "Fehler bei der Anmeldung"
    end
  rescue UserNotFoundException
    error401(
      message: "Fehler bei der Anmeldung",
      errors: {
        ident: "Der Benutzer '#{session["ident"]}' existiert nicht."
      }
    )
  rescue UserNoPropraTutorException
    error401(
      message: "Fehler bei der Anmeldung",
      errors: {
        ident: "Der Benutzer '#{session["ident"]}' ist kein ProPra Tutor."
      }
    )
  rescue WrongPasswordException
    error401(
      message: "Fehler bei der Anmeldung",
      errors: {
        password: "Das Passwort ist falsch."
      }
    )
  end
end

delete "/sessions" do
  body = request.body.read
  payload = JSON.parse body
  session = payload["session"]
  user = User.find_by token: session["token"]
  user.update! token_expires_at: DateTime.now
end

get "/*" do
  gzip File.read 'public/dist/index.html'
end
