`import Ember from 'ember'`
`import AuthenticatedRouteMixin from
  'simple-auth/mixins/authenticated-route-mixin'`

StatisticsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.find "rating"

`export default StatisticsRoute`
