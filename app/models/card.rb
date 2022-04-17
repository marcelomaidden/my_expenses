class Card < ApplicationRecord
  belongs_to :user
  belongs_to :card_category
  belongs_to :manager, class_name: 'User', optional: true

  enum status: %i[inactive active]
end
