`import Ember from 'ember'`

get = Ember.get

StatisticsController = Ember.Controller.extend
  barChartData: (->
    data = {}

    @get("model").forEach (rating) ->
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
  ).property "model.@each.ko", "model.@each.milestone"

`export default StatisticsController`
