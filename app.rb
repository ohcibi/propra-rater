require 'pry'
require 'gitlab'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require 'json'

require './app/models/rating'

g = Gitlab.client endpoint: "https://git.hhu.de/api/v3", private_token: ENV["gl_token"]
group = g.groups().find do |item|
  item.path == "programmierpraktikum-2015"
end

group_id = group.id

teams = g.group(group_id).projects.select do |project|
  project["name"].start_with? "team"
end

get "/teams" do
  {
    teams: teams
  }.to_json
end

get "/teams/:team_name" do
  team =  teams.find do |t|
    t["path"] == params["team_name"]
  end
  members = get_members_for g, params["team_name"]
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
end

def get_members_for git, project_name
  project = git.projects(per_page: 200).find do |item|
    item.name == project_name
  end
  git.team_members(project.id).map do |member|
    member = member.to_h
    member["ratings"] = Rating.where(member: member["id"]).pluck :id
    member
  end
end

get "/*" do
  File.read 'public/dist/index.html'
end
