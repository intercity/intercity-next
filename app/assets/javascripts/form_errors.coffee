$(document).on "turbolinks:load", ->
  new FormErrorHandler().reset()
  new FormErrorHandler().execute()

class @window.FormErrorHandler
  reset: ->
    $(".control").each ->
      $(this).find(".input").removeClass("is-danger")
      $(this).find(".fa-warning").remove()
      $(this).find(".help.is-danger").remove()
  execute: ->
    $(".field_with_errors").each ->
      field = $(this).find(".input")
      error_message = field.data("error")
      parent_control = $(this).parent()

      field.addClass("is-danger")
      parent_control.addClass("has-icon").addClass("has-icon-right")
      parent_control.append("<i class='fa fa-warning'></i>")
      if error_message
        parent_control.append("<span class='help is-danger'>#{error_message}</span>")
