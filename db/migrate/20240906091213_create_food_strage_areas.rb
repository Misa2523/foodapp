class CreateFoodStrageAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :food_strage_areas do |t|

      t.string :name, null: false
      t.integer :place, null: false

      t.timestamps
    end
  end
end
