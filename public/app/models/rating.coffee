`import DS from 'ember-data'`
`import BaseRating from '../lib/models/rating'`

attr = DS.attr

Rating = BaseRating.extend
  milestone: attr "number"

  comment: attr "string"

`export default Rating`
