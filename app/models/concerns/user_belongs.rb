module UserBelongs
  extend ActiveSupport::Concern

  included do
    belongs_to :user
  end

  def user_name
    user.name
  end
end