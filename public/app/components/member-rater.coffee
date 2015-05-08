`import Ember from 'ember'`

computed = Ember.computed

korrektOida = ->
  try
    audio = Ember.$("#korrektOida")[0]
    audio.pause()
    audio.currentTime = 0
    audio.play()

fail = ->
  try
    audio = new Audio "fail.ogg"
    audio.play()

MemberRaterComponent = Ember.Component.extend
  actions:
    ko: (num) ->
      if num == 1
        korrektOida()
      else if num == -1
        fail()

      @sendAction "action", num, @get("member.id"), @get "milestone"

    revoke: -> @sendAction "onRevoke", @get "member.id"

  milestone: (->
    1 + @get "member.currentMilestone"
  ).property "member.currentMilestone"

  finish: computed.gt "milestone", 12

  disableRevoke: computed.lt "member.ratings.length", 1

  tagName: "form"

  enableTooltips: (-> @$("[title]").tooltip()).on "didInsertElement"

  disableTooltips: (-> @$("[title]").tooltip "destroy" ).on "willDestroyElement"


`export default MemberRaterComponent`
