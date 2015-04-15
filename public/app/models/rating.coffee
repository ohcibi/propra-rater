`import DS from 'ember-data'`

attr = DS.attr

Rating = DS.Model.extend
  ko: attr "number"
  milestone: attr "number"

`export default Rating`
