require 'gitlab'

class Git
  attr_reader :teams, :group

  def initialize endpoint, token
    @git = Gitlab.client endpoint: endpoint, private_token: token

    @group = @git.groups().find do |item|
      item.path == "programmierpraktikum-2015"
    end

    @teams = @git.group(@group.id).projects.select do |project|
      project["name"].start_with? "team"
    end
  end

  def get_team name
    @teams.find do |t|
      t["path"] == name
    end
  end

  def get_members_for team_name
    team = get_team team_name
    @git.team_members(team["id"]).map do |member|
      member = member.to_h
      member["ratings"] = Rating.where(member: member["id"]).pluck :id
      member
    end
  end
end
