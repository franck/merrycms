module PagesHelper
  
  def display_page_category(page)
    if page.category
      page.category.name
    end
  end
  
  def display_state(page)
    t("pages.states.#{page.state}")
  end
  
  def display_events(page)
    html = ""
    page.available_events.each do |event|
      html << link_to(t("pages.events.#{event}"), method("#{event}_page_path").call(page))
      html << '&nbsp;'
    end
    raw(html)
  end
  
end
