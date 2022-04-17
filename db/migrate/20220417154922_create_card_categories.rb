class CreateCardCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :card_categories do |t|
      t.string :name
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
