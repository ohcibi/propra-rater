require 'json'
require 'pry'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require './config/environments'

require './app/helpers'

require './app/models/rating'
require './app/models/user'
require './lib/git'

git = Git.new "https://git.hhu.de/api/v3", ENV["gl_token"]

get "/teams" do
  protect!

  unless params["path"].nil?
    team = git.get_team params["path"]
    members = git.get_members_for params["path"]
    team["members"] = members.map { |m| m["id"] }

    json teams: [team], members: members, ratings: Rating.all
  else
    json teams: git.teams
  end
end

get "/ratings" do
  protect!

  json ratings: Rating.all
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

delete "/ratings/:id" do
  protect!

  rating = Rating.find params["id"]
  rating.destroy!

  json rating: rating
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
  File.read 'public/dist/index.html'
end
