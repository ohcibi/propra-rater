`import DS from 'ember-data'`

TeamSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    namespace: embedded: "always"

`export default TeamSerializer`
