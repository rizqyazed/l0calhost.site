module ApplicationHelper
  def status_screen_text
    if flash[:alert].present?
      return "#{flash[:alert]}"
    elsif flash[:notice].present?
      return "#{flash[:notice]}"
    end

    if content_for?(:screen_text)
      content_for(:screen_text)
    end
  end
end
