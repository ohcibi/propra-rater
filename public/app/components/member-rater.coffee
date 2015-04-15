`import Ember from 'ember'`

computed = Ember.computed
get = Ember.get

MemberRaterComponent = Ember.Component.extend
  actions:
    ko: (num) -> @sendAction "action", num, @get("member.id"), @get "milestone"

  milestone: (->
    ratings = @get("member.ratings").map (r) -> get r, "milestone"
    highest = Math.max 0, Math.max.apply null, ratings
    highest + 1
  ).property "member.ratings.[]"

  finish: computed.gt "milestone", 12

  tagName: "form"

`export default MemberRaterComponent`
