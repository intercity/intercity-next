$ ->
  $("body").on "click", "[data-behaviour~=perform-health-check]", (e) ->
    $(this).addClass("is-hidden")
    $(this).next("[data-behaviour~=performing-health-check]").removeClass("is-hidden")

