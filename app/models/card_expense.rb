class CardExpense < ApplicationRecord
  belongs_to :card
  belongs_to :payable, polymorphic: true, optional: true

  enum status: %i[inactive active]
  enum recurrent: { recurrent: 1 }
  enum frequency: %i[daily monthly yearly]

  before_create :set_installments

  private

  def set_installments
    self.total = installments * value
    self.last_date = due_date + installments.months
  end
end
