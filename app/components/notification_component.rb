# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  attr_reader :message, :type, :title

  def initialize(message:, type:, title:)
    @message = message
    @type = type
    @title = title
  end

  def notification_background
    case type
    when "notice"
      "alert alert-success"
    when "danger"
      "alert alert-danger"
    when "alert"
      "alert alert-danger"
    else
      "alert alert-dark"
    end
  end
end
