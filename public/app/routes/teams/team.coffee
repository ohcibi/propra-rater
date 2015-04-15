`import Ember from 'ember'`

TeamRoute = Ember.Route.extend
  model: (params) ->
    @store.find "team", params.path

`export default TeamRoute`
