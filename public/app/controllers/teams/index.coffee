`import Ember from 'ember'`

get = Ember.get

TeamsIndexController = Ember.Controller.extend
  filteredTeams: (->
    filter = @get "teamFilter"
    @get("model").filter (team) ->
      new RegExp("team#{filter}", "i").test get team, "path"
  ).property "teamFilter", "model.@each.path"

  groups: (->
    groups = @get("model").map((team) ->
      name = get team, "name"
      name.substr 4, name.length - 5
    ).uniq().map (group) =>
      number: group
      teams: @get("model").filter (team) ->
        new RegExp("team#{group}[1-9]$", "i").test get team, "path"
  ).property "model.@each.name"

  teamFilter: null

`export default TeamsIndexController`
