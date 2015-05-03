`import Ember from 'ember'`

LineChartComponent = Ember.Component.extend
  classNames: ["line-chart"]

  tagName: "canvas"

  createChart: (->
    g2d = @$().get(0).getContext "2d"
    @set "chart", new Chart(g2d).Line @get("chartData"), @get("options")
  ).on "didInsertElement"

  chartData: (->
    labels: [1..12].map (ms) -> "Meilenstein #{ms}"
    datasets: [
        {
            label: "Bis 2 fehlende K.O.s",
            fillColor: "rgba(223, 240, 216, 0.3)",
            strokeColor: "rgba(92, 184, 92, 0.85)",
            pointColor: "rgba(92, 184, 92, 0.85)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(60, 118, 61, 1)",
            data: @get "data.good"
        }
        {
            label: "Bis 4 fehlende K.O.s",
            fillColor: "rgba(252, 248, 227, 0.3)",
            strokeColor: "rgba(240, 173, 78, 0.8)",
            pointColor: "rgba(240, 173, 78, 0.8)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(138, 109, 59, 1)",
            data: @get "data.let4"
        }
        {
            label: "Mehr als 4 fehlende K.O.s",
            fillColor: "rgba(242, 222, 222, 0.3)",
            strokeColor: "rgba(217, 83, 79, 0.8)",
            pointColor: "rgba(217, 83, 79, 0.8)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(169, 68, 66, 1)",
            data: @get "data.get5"
        }
    ]
  ).property "data.good", "data.let4", "data.get5"

  data: {}

  options:
    multiTooltipTemplate: (element) -> "#{element.datasetLabel}: #{element.value}"

`export default LineChartComponent`
