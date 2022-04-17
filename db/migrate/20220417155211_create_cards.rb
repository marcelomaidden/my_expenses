class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :number
      t.date :expiration
      t.integer :status, default: 1
      t.references :card_category, null: false, foreign_key: true
      t.integer :manager_id
      t.string :cvv

      t.timestamps
    end
  end
end
