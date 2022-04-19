class CreateCardExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :card_expenses do |t|
      t.references :card, null: false, foreign_key: true
      t.references :payable, polymorphic: true, null: false
      t.string :description, null: false
      t.integer :installments, default: 1
      t.float :value
      t.date :due_date
      t.date :last_date
      t.integer :status, default: 1
      t.integer :recurrent, default: 0
      t.integer :frequency, default: 1
      t.float :total

      t.timestamps
    end
  end
end
