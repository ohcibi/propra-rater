`import Ember from 'ember'`
`import AuthenticatedRouteMixin from
  'simple-auth/mixins/authenticated-route-mixin'`

StatisticsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> Ember.$.getJSON "/statistics"

`export default StatisticsRoute`
