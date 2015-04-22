require 'json'
require 'pry'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require './config/environments'

require './app/models/rating'
require './app/models/user'
require './lib/git'
require './lib/ldap'

git = Git.new "https://git.hhu.de/api/v3", ENV["gl_token"]

raise "Please export $funkident with the functional ident" unless ENV["funkident"]
raise "Please export $funkpw with the functional password" unless ENV["funkpw"]
raise "Please export the ldap host as $ldaphost" unless ENV["ldaphost"]

ldap = Ldap.new ENV["funkident"], ENV["funkpw"], ENV["ldaphost"]

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

post "/sessions" do
  body = request.body.read
  payload = JSON.parse body
  session = payload["session"]

  if ldap.authenticate? session["ident"], session["password"]
    user = User.find_or_create_by ident: session["ident"]
    user.regenerate_token!
    json session: { token: user.token }
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
