module FlashMessagesHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-danger"
    when "notice"
      "alert-info"
    else
      flash_type
    end
  end

  def flash_messages
    flash.map do |msg_type, message|
      content_tag(:div, class: "alert #{bootstrap_class_for(msg_type)}") do
        content_tag(:button, "x", class: "close", data: { dismiss: "alert" }) + message
      end
    end.join.html_safe
  end
end
