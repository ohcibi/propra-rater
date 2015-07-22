`import Ember from 'ember'`
`import AuthenticatedRouteMixin from
  'simple-auth/mixins/authenticated-route-mixin'`

MembersRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.find "member"

`export default MembersRoute`
