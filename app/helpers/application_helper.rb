module ApplicationHelper
  def flash_message
    messages = ""
    [:notice, :success, :info, :warning, :error].each do |type|
      if flash[type]
        messages += "<p id='flash-notice' class='notice notice-show #{type}'><span>#{flash[type]}</span></p>"
      end
    end

    messages.html_safe
  end
end
