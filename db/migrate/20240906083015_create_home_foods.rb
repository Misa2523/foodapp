class CreateHomeFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :home_foods do |t|

      t.references :customer, null: false, foreign_key: {to_table: :customers}
      # t.references :genre, null: false, foreign_key: {to_table: :genres}, index: true
      t.string :name, null: false
      t.string :amount, null: false
      t.date :expiration_date, index: true
      t.date :best_before_date, index: true

      t.timestamps
    end
  end
end
