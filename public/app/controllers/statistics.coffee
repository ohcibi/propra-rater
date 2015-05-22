`import Ember from 'ember'`

computed = Ember.computed

get = Ember.get

StatisticsController = Ember.Controller.extend
  barChartData: (->
    data = {}

    @get("model.ratings").forEach (rating) ->
      milestone = get rating, "milestone"
      msRatings = data[milestone] ?=
        number: milestone
        full: 0
        none: 0
        half: 0
        diarrhea: 0

      ko = switch get rating, "ko"
        when 0 then "none"
        when 0.5 then "half"
        when 1 then "full"
        when -1 then "diarrhea"

      msRatings[ko] ?= 0
      msRatings[ko]++

    milestones = (data[milestone] for milestone of data)
    milestones.sortBy "number"
  ).property "model.ratings.@each.ko", "model.ratings.@each.milestone"

  lineChartData: computed.reads "model.active"

`export default StatisticsController`
