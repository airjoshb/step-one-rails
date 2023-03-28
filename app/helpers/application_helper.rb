module ApplicationHelper
  def formatted_price(amount)
    sprintf("$%0.2f", amount / 100.0)
  end

  def display_price(amount)
    sprintf("$%0.0f", amount / 100.0)
  end

  def active_link_to(name, path)
    content_tag(:div, class: "#{'active fw-bold' if current_page?(path)} nav-link") do
      link_to name, path
    end
  end 

  def deep_active_link_to(name, path)
    content_tag(:div, class: "#{'active fw-bold' if current_page?(path)} category") do
      link_to name, path
    end 
  end 

  def deep_active_sub_link_to(name, path)
    content_tag(:div, class: "#{'active fw-bold' if current_page?(path)} category subcategory border-t-2 border-solid") do
      link_to name, path
    end 
  end 
 
end
