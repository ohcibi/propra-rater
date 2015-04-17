`import Ember from 'ember'`

get = Ember.get

TeamsIndexController = Ember.Controller.extend
  filteredTeams: (->
    filter = @get "teamFilter"
    @get("model").filter (team) ->
      new RegExp("team#{filter}", "i").test get team, "path"
  ).property "teamFilter", "model.@each.path"

  teamFilter: null

`export default TeamsIndexController`
