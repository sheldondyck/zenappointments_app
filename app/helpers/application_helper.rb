module ApplicationHelper
  def app_name
    'ZenAppointments'
  end

  def title
    if @title.nil?
      app_name
    else
      app_name + ' | ' + @title
    end
  end

  def flash_handler
    # TODO: check that css_alert_map is complete
    css_alert_map = {:notice => 'info', :alert => 'danger', :error => 'danger'}
    div = ""
    flash.each do |key, value|
      css_alert = css_alert_map[key] ||= 'danger'
      div += "<div class='alert alert-#{css_alert}' data-dismiss='alert'>"
      div += "<h4>Opps...</h4>" if key == :alert || key == :error
      div += "<strong>#{value}</strong>"
      div += "</div>"
    end
    div
  end

  def menu_link_icon_to icon_name, href, alt = ''
    unless alt.blank?
      link_to raw("<i class='icon-#{icon_name} icon-large'></i>"), href, {alt: alt, id: "link-#{icon_name}"}
    else
      link_to raw("<i class='icon-#{icon_name} icon-large'></i>"), href, {id: "link-#{icon_name}"}
    end
  end

  def link_icon_to icon_name, href, alt = ''
    unless alt.blank?
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {alt: alt, class: 'btn btn-default', id: "link-#{icon_name}"}
    else
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {class: 'btn btn-default', id: "link-#{icon_name}"}
    end
  end

  def remote_link_icon_to icon_name, href, alt = ''
    unless alt.blank?
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {alt: alt, class: 'btn btn-default', id: "link-#{icon_name}", data: {remote: 'true'}}
    else
      link_to raw("<i class='icon-#{icon_name}'></i>"), href, {class: 'btn btn-default', id: "link-#{icon_name}", data: {remote: 'true'}}
    end
  end

  def active(cntrl_name)
    if cntrl_name == controller.controller_name + '#' + controller.action_name then
      return 'active'
    end
  end

  def error_class(h, sym)
    if h.errors.messages.has_key?(sym)
      'has-error'
    end
  end

  def error_message(model, sym)
    if model.errors.messages.has_key?(sym)
      model.errors.messages[sym][0].capitalize unless model.errors.messages[sym][0].nil?
    end
  end

  def www_url
    if Rails.env == 'development' or Rails.env == 'test'
      'http://127.0.0.1:4000'
    else
      'http://www.zenappointments.com'
    end
  end
end
