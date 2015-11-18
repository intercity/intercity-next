$ ->
  $("body").on "click", "[data-behaviour~=test-server]", (e) ->
    e.preventDefault()
    $(this).addClass("hidden")
    $(this).next("[data-server-status~=testing]").removeClass("hidden")
    $.post($(this).data("test-url"))
