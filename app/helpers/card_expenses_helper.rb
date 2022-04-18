module CardExpensesHelper
  def payable_selected(payable)
    @card_expense.payable_type == payable.payable_type &&  @card_expense.payable_id == payable.payable_id
  end
end
