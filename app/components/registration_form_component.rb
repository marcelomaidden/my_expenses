class RegistrationFormComponent < ViewComponent::Base
  attr_reader :resource, :type

  def initialize(resource:, type:)
    @resource = resource
    @type = type
  end
end
