module ManagerBelongs
  extend ActiveSupport::Concern

  included do
    belongs_to :manager, class_name: 'User'
  end

  def manager_name
    manager&.name
  end
end
