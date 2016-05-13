$(document).on 'turbolinks:load', ->
  if $('#server_load_history svg').length > 0
    d3.json $('#server_load_history').data('url'), (data) ->
      nv.addGraph ->
        chart = nv.models.lineChart().useInteractiveGuideline(true)
        chart.xAxis.axisLabel('Timeline').tickFormat (d) ->
          d3.time.format('%H:%M') new Date(d)
        chart.forceY [0,100]
        chart.yAxis.axisLabel('Usage (%)').range [0,100]
        d3.select('#server_load_history svg').datum(data).transition().duration(500).call chart
        nv.utils.windowResize chart.update
        chart
