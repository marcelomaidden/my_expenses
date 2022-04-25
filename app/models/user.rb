class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cards
  has_many :phones

  def managed_cards
    Card.where(manager: self)
  end

  def managed_phones
    Phone.where(manager: self)
  end
end
