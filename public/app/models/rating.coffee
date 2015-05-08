`import DS from 'ember-data'`
`import BaseRating from '../lib/models/rating'`

attr = DS.attr

computed = Ember.computed

Rating = BaseRating.extend
  milestone: attr "number"

  comment: attr "string"

  failed: computed.equal "sanity", "failed"

`export default Rating`
