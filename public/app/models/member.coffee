`import DS from 'ember-data'`

attr = DS.attr
hasMany = DS.hasMany

get = Ember.get
mapBy = Ember.computed.mapBy
sum = Ember.computed.sum

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

  kos: mapBy "ratings", "ko"

  koSum: sum "kos"

  sanity: (->
    level = @get("currentMilestone") - @get "koSum"
    if level < 2
      "sane"
    else if level < 4
      "endangered"
    else
      "lamebrain"
  ).property "currentMilestone", "koSum"

`export default Member`
