module CardExpensesHelper
  def payable_selected(payable)
    @card_expense.payable_type == payable.payable_type &&  @card_expense.payable_id == payable.payable_id
  end

  def card_expenses_form_url
    return card_card_expenses_path if @card_expense.id.blank?

    card_card_expense_path
  end
end
