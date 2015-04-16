`import Ember from 'ember'`

get = Ember.get

TeamsTeamMemberRoute = Ember.Route.extend
  model: (params) ->
    @modelFor("team").get("members").find (member) ->
      get(member, "username") == params.username

`export default TeamsTeamMemberRoute`
