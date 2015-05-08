`import Ember from 'ember'`
`import Notify from 'ember-notify'`

computed = Ember.computed

MemberRatingComponent = Ember.Component.extend
  classNames: ["member-rating"]

  classNameBindings: ["sanity"]

  mouseEnter: ->
    @set "editing", true

  mouseLeave: ->
    @set "editing", false
    rating = @get "rating"
    if rating.get "isDirty"
      rating.save().then( =>
        Notify.success "Bewertung für #{@get "name"} gespeichert",
          radius: true
      ).catch =>
        Notify.warning "Fehler beim Speichern der Bewertung für #{@get "name"}",
          radius: true


`export default MemberRatingComponent`
