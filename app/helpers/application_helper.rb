module ApplicationHelper
  def full_title(page_title = nil)
    base_title = 'jizoo blog'
    if page_title.present?
      "#{base_title} - #{page_title}"
    else
      base_title
    end
  end
end
