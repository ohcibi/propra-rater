`import Ember from 'ember'`

computed = Ember.computed

BarChartComponent = Ember.Component.extend
  classNames: ["bar-chart"]

  tagName: "canvas"

  createChart: (->
    g2d = @$().get(0).getContext "2d"
    @set "chart", new Chart(g2d).Bar @get("chartData"), @get("options")
  ).on "didInsertElement"

  chartData: (->
    labels: [1..12].map (ms) -> "Meilenstein #{ms}"
    datasets: [
        {
            label: "Durchfall",
            fillColor: "rgba(0, 0, 0, 0.5)",
            strokeColor: "rgba(0, 0, 0, 0.8)",
            highlightFill: "rgba(30, 30, 30, 0.75)",
            highlightStroke: "rgba(30, 30, 30, 1)",
            data: @get "diarrhea"
        }
        {
            label: "0 K.O.",
            fillColor: "rgba(217, 83, 79, 0.5)",
            strokeColor: "rgba(217, 83, 79, 0.8)",
            highlightFill: "rgba(217, 83, 79, 0.75)",
            highlightStroke: "rgba(169, 68, 66, 1)",
            data: @get "none"
        }
        {
            label: "½ K.O.",
            fillColor: "rgba(240, 173, 78, 0.5)",
            strokeColor: "rgba(240, 173, 78, 0.8)",
            highlightFill: "rgba(240, 173, 78, 0.75)",
            highlightStroke: "rgba(138, 109, 59, 1)",
            data: @get "half"
        }
        {
            label: "1 K.O.",
            fillColor: "rgba(92, 184, 92, 0.6)",
            strokeColor: "rgba(92, 184, 92, 0.85)",
            highlightFill: "rgba(92, 184, 92, 0.75)",
            highlightStroke: "rgba(60, 118, 61, 1)",
            data: @get "full"
        }
    ]
  ).property "none", "half", "full"

  none: computed.mapBy "data", "none"

  half: computed.mapBy "data", "half"

  full: computed.mapBy "data", "full"

  diarrhea: computed.mapBy "data", "diarrhea"

  data: []

  options:
    multiTooltipTemplate: (element) -> "#{element.datasetLabel}: #{element.value}"

`export default BarChartComponent`
