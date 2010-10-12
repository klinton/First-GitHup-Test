module ApplicationHelper

  # Return a title on a per-page bisis.
  def logo
   image_tag("logo.png", :alt => "Sample App", :class => "round") 
  end

  def title
    base_title = "Ruby on Rails SampleApp"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
