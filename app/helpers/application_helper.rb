module ApplicationHelper
  def page_title(title)
    base_title = 'Microtwit'
    title.empty? ? base_title : "#{base_title} - #{title}"
  end
end
