`import Ember from 'ember'`

TeamRoute = Ember.Route.extend
  actions:
    ko: (num, id, milestone) ->
      rating = @store.createRecord "rating",
        ko: num
        milestone: milestone
        member: @store.getById "member", id
      rating.save()

  model: (params) ->
    @store.find "team", params.path

`export default TeamRoute`
