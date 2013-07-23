module ApplicationHelper
  def title
    if @title.nil?
      'ZenAppointments'
    else
      'ZenAppointments | ' + @title
    end
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

  def link_icon_to icon_name, href, alt = ''
    unless alt.blank?
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {alt: alt, class: 'btn', id: "link-#{icon_name}"}
    else
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {class: 'btn', id: "link-#{icon_name}"}
    end
  end

  def remote_link_icon_to icon_name, href, alt = ''
    unless alt.blank?
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {alt: alt, class: 'btn', id: "link-#{icon_name}", data: {remote: 'true'}}
    else
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {class: 'btn', id: "link-#{icon_name}", data: {remote: 'true'}}
    end
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
