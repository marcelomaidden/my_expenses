class CardCategory < ApplicationRecord
  has_many :cards

  enum status: %i[inactive active]
end
