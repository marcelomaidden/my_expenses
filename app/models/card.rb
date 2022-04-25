class Card < ApplicationRecord
  include UserBelongs
  include ManagerBelongs

  belongs_to :card_category
  has_many :expenses, as: :billable

  enum status: %i[inactive active]

  def category_name
    card_category.name
  end
end
