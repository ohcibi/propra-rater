`import Ember from 'ember'`

MembersRoute = Ember.Route.extend
  model: -> @store.find "member"

`export default MembersRoute`
