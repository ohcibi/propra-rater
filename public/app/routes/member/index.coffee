`import Ember from 'ember'`

get = Ember.get

MemberIndexRoute = Ember.Route.extend
  model: ->
    member = @modelFor "member"
    pretest = get member, "pretest"
    pretest = @store.createRecord "pretest", member: member unless pretest?

    pretest

`export default MemberIndexRoute`
