$ ->
  $("body").on "click", "[data-behaviour~=test-server]", (e) ->
    e.preventDefault()
    $(this).addClass("is-hidden")
    $(this).next("[data-server-status~=testing]").removeClass("is-hidden")
    $.post($(this).data("test-url"))
