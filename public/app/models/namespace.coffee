`import DS from 'ember-data'`

attr = DS.attr

Namespace = DS.Model.extend
  name: attr "string"
  path: attr "string"

`export default Namespace`
