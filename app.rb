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
  json teams: git.teams
end

get "/teams/:team_name" do
  team = git.get_team params["team_name"]
  members = git.get_members_for params["team_name"]
  team["members"] = members.map { |m| m["id"] }

  json team: team, members: members, ratings: Rating.all
end

post "/ratings" do
  body = request.body.read
  payload = JSON.parse body
  rating = Rating.new payload["rating"]
  rating.save
  json rating: rating
end

put "/ratings/:id" do
  body = request.body.read
  payload = JSON.parse body
  json rating: Rating.update(params["id"], payload["rating"])
end

post "/sessions" do
  body = request.body.read
  payload = JSON.parse body
  session = payload["session"]

  if authenticate? session["ident"], session["password"]
    json session: { token: authenticate!(session["ident"]) }
  else
    status 401
    json error: "Wrong username or password"
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
