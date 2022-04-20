module ExpensesHelper
  def payable_selected(payable)
    @expense.payable_type == payable.payable_type &&  @expense.payable_id == payable.payable_id
  end

  def billable_selected(billable)
    @expense.billable_type == billable.payable_type &&  @expense.billable_id == billable.billable_id
  end
end
