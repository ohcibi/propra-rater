`import Ember from 'ember'`

isEmpty = Ember.isEmpty

MemberIndexController = Ember.Controller.extend
  actions:
    save: ->
      @set "error", isEmpty @get "model.ko"
      @get("model").save() unless @get "error"

  resetError: (->
    @set "error", false if @get("model.ko")?
  ).observes "model.ko"

`export default MemberIndexController`
