module ApplicationHelper
  def status_screen_text(model = nil)
    if model && model.errors.any?
      return model.errors.first.message
    end

    if flash[:notice].present?
      return "#{flash[:notice]}"
    end

    if content_for?(:screen_text)
      content_for(:screen_text)
    end
  end
end
