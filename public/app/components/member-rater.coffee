`import Ember from 'ember'`
`import playAudio from '../lib/play-audio'`

computed = Ember.computed

playSound = (num) ->
  playAudio switch num
    when 1 then "korrekt-oida.ogg"
    when 0.5 then "slap.ogg"
    when 0 then "zonk.ogg"
    when -1 then "fail.ogg"

MemberRaterComponent = Ember.Component.extend
  actions:
    ko: (num) ->
      playSound num
      @sendAction "action", num, @get("member.id"), @get "milestone"

    revoke: -> @sendAction "onRevoke", @get "member.id"

  milestone: (->
    1 + @get "member.currentMilestone"
  ).property "member.currentMilestone"

  finish: computed.gt "milestone", 12

  failedOrFinished: computed.or "finish", "member.failed"

  disableRevoke: computed.lt "member.ratings.length", 1

  tagName: "form"

  enableTooltips: (-> @$("[title]").tooltip()).on "didInsertElement"

  disableTooltips: (-> @$("[title]").tooltip "destroy" ).on "willDestroyElement"


`export default MemberRaterComponent`
