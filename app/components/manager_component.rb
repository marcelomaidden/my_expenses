class ManagerComponent < ViewComponent::Base
  attr_reader :managers, :model, :form

  def initialize(managers:, model:, form:)
    @managers = managers
    @model = model
    @form = form
  end
end
