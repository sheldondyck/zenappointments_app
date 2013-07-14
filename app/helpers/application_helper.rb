module ApplicationHelper
  def title
    'zenapplication'
  end

  def flash_handler
    div = ""
    flash.each do |key, value|
      div += "<div class='container'>"
      div += "<div class='alert alert-#{key}' data-dismiss='alert'>"
      div += "<strong>#{value}</strong>"
      div += "</div></div>"
    end
    div
  end

  def error_class(h, sym)
    if h.errors.messages.has_key?(sym)
      "error"
    end
  end

  def error_message(model, sym)
    if model.errors.messages.has_key?(sym)
      model.errors.messages[sym][0].capitalize unless model.errors.messages[sym][0].nil?
    end
  end
end
