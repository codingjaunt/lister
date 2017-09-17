# Helper main class
module ApplicationHelper
  def flash_messages(message)
    if message.nil?
      []
    elsif message.respond_to?(:each)
      message
    else
      [message]
    end
  end
end
