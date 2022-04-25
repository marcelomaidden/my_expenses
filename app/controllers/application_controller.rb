class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def set_managers
    @managers = User.all.order(name: :asc).collect { |u| [u.name, u.id]}
  end

  def set_billable(model:)
    @billable = model.find(params[:id])
  end
end
