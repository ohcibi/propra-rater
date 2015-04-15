`import Ember from 'ember'`

MemberRaterComponent = Ember.Component.extend
  actions:
    ko: (num) -> @sendAction "action", num, @get("member.id"), @get "milestone"

  milestones: [1..12]

  tagName: "form"

`export default MemberRaterComponent`
