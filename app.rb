require 'json'
require 'pry'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'

require './app/models/rating'
require './lib/git'

git = Git.new "https://git.hhu.de/api/v3", ENV["gl_token"]

get "/teams" do
  {
    teams: git.teams
  }.to_json
end

get "/teams/:team_name" do
  team = git.get_team params["team_name"]
  members = git.get_members_for params["team_name"]
  team["members"] = members.map { |m| m["id"] }
  {
    team: team,
    members: members,
    ratings: Rating.all
  }.to_json
end

post "/ratings" do
  body = request.body.read
  payload = JSON.parse body
  rating = Rating.new payload["rating"]
  rating.save
  { rating: rating }.to_json
end

put "/ratings/:id" do
  body = request.body.read
  payload = JSON.parse body
  { rating: Rating.update(params["id"], payload["rating"]) }.to_json
end

get "/*" do
  File.read 'public/dist/index.html'
end
