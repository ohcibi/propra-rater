`import DS from 'ember-data'`

attr = DS.attr
hasMany = DS.hasMany

mapBy = Ember.computed.mapBy
sum = Ember.computed.sum

Member = DS.Model.extend
  name: attr "string"
  username: attr "string"
  state: attr "string"
  avatarUrl: attr "string"
  accessLevel: attr "number"

  ratings: hasMany "rating"

  kos: mapBy "ratings", "ko"

  koSum: sum "kos"

`export default Member`
