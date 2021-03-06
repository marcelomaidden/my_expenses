class Expense < ApplicationRecord
  belongs_to :billable, polymorphic: true
  belongs_to :payable, polymorphic: true, optional: true

  enum status: %i[inactive active]
  enum recurrent: { recurrent: 1 }
  enum frequency: %i[daily monthly yearly]

  validates :value, :description, presence: true

  before_create :set_installments

  def billable_name
    billable.try(:name) || billable.try(:number)
  end

  def payable_name
    payable&.try(:name) || payable&.try(:number)
  end

  private

  def set_installments
    self.total = installments * value
    self.last_date = due_date + installments.months if installments > 1
    self.last_date = due_date if installments == 1
  end
end
