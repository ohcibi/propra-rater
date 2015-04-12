require 'pry'
require 'gitlab'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'

g = Gitlab.client endpoint: "https://git.hhu.de/api/v3", private_token: ENV["gl_token"]
group_id = g.groups().find do |group|
  group.path == "programmierpraktikum-2015"
end.id

get "/" do
  File.read 'public/dist/index.html'
end

get "/teams" do
  g.group(group_id).projects.select do |project|
    project["name"].start_with? "team"
  end.to_json
end
