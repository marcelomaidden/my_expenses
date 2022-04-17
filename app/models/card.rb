class Card < ApplicationRecord
  belongs_to :user
  belongs_to :card_category
  has_many :card_expenses
  belongs_to :manager, class_name: 'User', optional: true

  enum status: %i[inactive active]
end
