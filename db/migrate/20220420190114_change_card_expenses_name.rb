class ChangeCardExpensesName < ActiveRecord::Migration[6.0]
  def change
    remove_column :card_expenses, :card_id
    remove_index :card_expenses, name: "index_card_expenses_on_payable_type_and_payable_id"
    rename_table :card_expenses, :expenses
    add_reference :expenses, :billable, polymorphic: true, null: false
  end
end
