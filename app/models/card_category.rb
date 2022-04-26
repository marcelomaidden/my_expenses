class CardCategory < ApplicationRecord
  has_many :cards
  STATUS = { inactive: 0, active: 1 }.freeze
  enum status: STATUS

  validates :name, presence: true
end
