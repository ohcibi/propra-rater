`import DS from 'ember-data'`

attr = DS.attr
belongsTo = DS.belongsTo

Rating = DS.Model.extend
  ko: attr "number"
  milestone: attr "number"
  member: belongsTo "member"

  sanity: (->
    switch +@get "ko"
      when 1 then "success"
      when 0.5 then "warning"
      when 0 then "danger"
  ).property "ko"

`export default Rating`
