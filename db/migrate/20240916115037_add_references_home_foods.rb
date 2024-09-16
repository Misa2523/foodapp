class AddReferencesHomeFoods < ActiveRecord::Migration[6.1]
  def change
    add_reference :home_foods, :genre, null: false, foreign_key: {to_table: :genres}, index: true
  end
end
