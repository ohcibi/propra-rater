`import Ember from 'ember'`
`import Notify from 'ember-notify'`

get = Ember.get

RatingRoute = Ember.Route.extend
  actions:
    saveRating: (rating) ->
      rating.save().then(->
        Notify.success "Bewertung gespeichert",
          radius: true
      ).catch ->
        Notify.warning "Fehler beim Speichern der Bewertung",
          radius: true

  model: (params) ->
    @modelFor("member").get("ratings").find (rating) ->
      +get(rating, "milestone") == +params.milestone

`export default RatingRoute`
