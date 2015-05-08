`import Ember from 'ember'`
`import playAudio from '../lib/play-audio'`

computed = Ember.computed

MemberRaterComponent = Ember.Component.extend
  actions:
    ko: (num) ->
      if num == 1
        playAudio "korrekt-oida.ogg"
      else if num == -1
        playAudio "fail.ogg"

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
