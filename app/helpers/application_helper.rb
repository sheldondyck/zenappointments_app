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
end
