`import Ember from 'ember'`

MemberIndexRoute = Ember.Route.extend
  model: ->
    member = @modelFor "member"
    @store.createRecord "pretest", member: member

`export default MemberIndexRoute`
