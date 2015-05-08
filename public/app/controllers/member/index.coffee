`import Ember from 'ember'`
`import Notify from 'ember-notify'`

isEmpty = Ember.isEmpty

MemberIndexController = Ember.Controller.extend
  actions:
    save: ->
      @set "error", isEmpty @get "model.ko"
      unless @get "error"
        memberName= @get "model.member.name"
        @get("model").save().then (->
          Notify.success "Vortest für #{memberName} gespeichert",
            radius: true
        ), (error) =>
          Notify.warning(
            "Fehler beim Seichern des Vortests für #{memberName}",
            radius: true
          )

  resetError: (->
    @set "error", false if @get("model.ko")?
  ).observes "model.ko"

`export default MemberIndexController`
