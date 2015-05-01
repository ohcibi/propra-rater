`import Ember from 'ember'`
`import Notify from 'ember-notify'`

get = Ember.get

TeamRoute = Ember.Route.extend
  actions:
    ko: (num, id, milestone) ->
      member = @store.getById "member", id
      rating = @store.createRecord "rating",
        ko: num
        milestone: milestone
        member: member
      rating.save().then (->
        Notify.success "Bewertung für #{get member, "name"} gespeichert",
          radius: true
      ), (error) =>
        Notify.warning(
          "Fehler beim Seichern der Bewertung für #{get member, "name"}",
          radius: true
        )
        @store.unloadRecord rating

  model: (params) ->
    @store.find("team", path: params.path).then (teams) ->
      teams.get("firstObject")

`export default TeamRoute`
