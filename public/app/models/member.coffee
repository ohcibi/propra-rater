`import DS from 'ember-data'`

attr = DS.attr
hasMany = DS.hasMany
belongsTo = DS.belongsTo

computed = Ember.computed
get = Ember.get

Member = DS.Model.extend
  name: attr "string"
  username: attr "string"
  state: attr "string"
  avatar_url: attr "string"
  access_level: attr "number"

  ratings: hasMany "rating"

  pretest: belongsTo "pretest"

  team: belongsTo "team"

  currentMilestone: (->
    milestones = @get("ratings").map (r) -> get r, "milestone"
    Math.max 0, Math.max.apply null, milestones
  ).property "ratings.[]"

  failed: (->
    @get("kos").any (ko) -> ko == -1
  ).property "kos"

  hasPretest: (->
    @get("pretest.ko")?
  ).property "pretest.ko"

  kos: (->
    @get("ratings").map (rating) ->
      rating = +get rating, "ko"
  ).property "ratings.@each.ko"

  koSum: computed.sum "unfailedKos"

  sanity: (->
    if @get "failed"
      "failed"
    else
      level = @get("currentMilestone") - @get "koSum"
      pretest = @get("pretest.ko") ? 0
      if level <= 2
        "success"
      else if level <= 4
        if level - pretest > 2
          "warning"
        else
          "semi-success"
      else
        if level - pretest > 4
          "danger"
        else
          "semi-warning"
  ).property "currentMilestone", "koSum", "failed", "pretest.ko"

  unfailedKos: (->
    @get("kos").filter (ko) -> ko in [0, .5, 1]
  ).property "kos"

`export default Member`
