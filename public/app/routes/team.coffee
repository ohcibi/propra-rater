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

    revoke: (id) ->
      member = @store.getById "member", id
      rating = get member, "ratings.lastObject"
      rating.destroyRecord().then (->
        Notify.success(
          "Letzte Bewertung für #{get member, "name"} zurückgenommen",
          radius: true
        )
      ), (error) ->
        Notify.warning(
          "Fehler beim Zurücknehmen der Bewertung für #{get member, "name"}",
          radius: true
        )

  model: (params) ->
    @store.find("team", path: params.path).then (teams) ->
      teams.get("firstObject")

`export default TeamRoute`
