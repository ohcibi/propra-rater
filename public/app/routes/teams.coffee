`import Ember from 'ember'`

TeamsRoute = Ember.Route.extend
  model: -> @store.find "team"

`export default TeamsRoute`
