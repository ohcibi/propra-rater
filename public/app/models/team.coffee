`import DS from 'ember-data'`

attr = DS.attr
belongsTo = DS.belongsTo

Team = DS.Model.extend
  name: DS.attr "string"
  path: DS.attr "string"
  name_with_namespace: DS.attr "string"
  web_url: DS.attr "string"

  namespace: belongsTo "namespace"

`export default Team`
