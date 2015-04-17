`import Ember from 'ember'`

MemberRatingComponent = Ember.Component.extend
  mouseEnter: ->
    @set "editing", true

  mouseLeave: ->
    @set "editing", false
    rating = @get "rating"
    rating.save() if rating.get "isDirty"

`export default MemberRatingComponent`
