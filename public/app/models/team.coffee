`import DS from 'ember-data'`

Team = DS.Model.extend
  name: DS.attr "string"
  name_with_namespace: DS.attr "string"
  web_url: DS.attr "string"

`export default Team`
