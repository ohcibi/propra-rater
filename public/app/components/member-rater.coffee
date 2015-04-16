`import Ember from 'ember'`

computed = Ember.computed

MemberRaterComponent = Ember.Component.extend
  actions:
    ko: (num) -> @sendAction "action", num, @get("member.id"), @get "milestone"

  milestone: (->
    1 + @get "member.currentMilestone"
  ).property "member.currentMilestone"

  finish: computed.gt "milestone", 12

  tagName: "form"

`export default MemberRaterComponent`
