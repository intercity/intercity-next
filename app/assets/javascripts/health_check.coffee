$ ->
  $("body").on "click", "[data-behaviour~=perform-health-check]", (e) ->
    $(this).addClass("hidden")
    $(this).next("[data-behaviour~=performing-health-check]").removeClass("hidden")

