`import Ember from 'ember'`

get = Ember.get

StatisticsController = Ember.Controller.extend
  barChartData: (->
    data = {}

    @get("model.ratings").forEach (rating) ->
      milestone = get rating, "milestone"
      msRatings = data[milestone] ?= number: milestone

      ko = switch get rating, "ko"
        when 0 then "none"
        when 0.5 then "half"
        when 1 then "full"

      msRatings[ko] ?= 0
      msRatings[ko]++

    milestones = (data[milestone] for milestone of data)
    milestones.sortBy "number"
  ).property "model.ratings.@each.ko", "model.ratings.@each.milestone"

`export default StatisticsController`
