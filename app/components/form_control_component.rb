# frozen_string_literal: true

class FormControlComponent < ViewComponent::Base
  attr_reader :icon_type

  def initialize(icon_type: nil)
    @icon_type = icon_type
  end
end
