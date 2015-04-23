`import Ember from 'ember'`
`import AuthenticatedRouteMixin from
  'simple-auth/mixins/authenticated-route-mixin'`

TeamsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.find "team"

`export default TeamsRoute`
