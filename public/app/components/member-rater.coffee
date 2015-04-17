`import Ember from 'ember'`

computed = Ember.computed

korrektOida = ->
  audio = Ember.$("#korrektOida")[0]
  audio.pause()
  audio.currentTime = 0
  audio.play()

MemberRaterComponent = Ember.Component.extend
  actions:
    ko: (num) ->
      if num == 1
        korrektOida()

      @sendAction "action", num, @get("member.id"), @get "milestone"

  milestone: (->
    1 + @get "member.currentMilestone"
  ).property "member.currentMilestone"

  finish: computed.gt "milestone", 12

  tagName: "form"

`export default MemberRaterComponent`
