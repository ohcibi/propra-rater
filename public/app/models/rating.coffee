`import DS from 'ember-data'`

attr = DS.attr
belongsTo = DS.belongsTo

Rating = DS.Model.extend
  ko: attr "number"
  milestone: attr "number"
  member: belongsTo "member"

`export default Rating`
