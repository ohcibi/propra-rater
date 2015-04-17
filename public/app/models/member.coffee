`import DS from 'ember-data'`

attr = DS.attr
hasMany = DS.hasMany

computed = Ember.computed
get = Ember.get

Member = DS.Model.extend
  name: attr "string"
  username: attr "string"
  state: attr "string"
  avatar_url: attr "string"
  access_level: attr "number"

  ratings: hasMany "rating"

  currentMilestone: (->
    ratings = @get("ratings").map (r) -> get r, "milestone"
    Math.max 0, Math.max.apply null, ratings
  ).property "ratings.[]"

  kos: (->
    @get("ratings").map (rating) -> +get rating, "ko"
  ).property "ratings.@each.ko"

  koSum: computed.sum "kos"

  sanity: (->
    level = @get("currentMilestone") - @get "koSum"
    if level < 2
      "success"
    else if level < 4
      "warning"
    else
      "danger"
  ).property "currentMilestone", "koSum"

`export default Member`
