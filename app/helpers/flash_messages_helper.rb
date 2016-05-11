module FlashMessagesHelper
  def bulma_class_for(flash_type)
    case flash_type
    when "success"
      "is-success"
    when "error"
      "is-danger"
    when "alert"
      "is-danger"
    when "notice"
      "is-info"
    else
      flash_type
    end
  end

  def flash_messages
    flash.map do |msg_type, message|
      content_tag(:div, class: "notification #{bulma_class_for(msg_type)}") do
        content_tag(:button, "", class: "delete") + message
      end
    end.join.html_safe
  end
end
