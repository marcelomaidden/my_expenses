class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :manager_id
      t.string :number

      t.timestamps
    end
  end
end
