class Phone < ApplicationRecord
  validates :number, presence: true
  include UserBelongs
  include ManagerBelongs

  has_many :expenses, as: :billable
end
