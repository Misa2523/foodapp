class CreateCookingPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :cooking_posts do |t|

      t.references :customer, null: false, foreign_key: {to_table: :customers}
      t.string :name, null: false
      t.text :introduction, null: false, index: true

      t.timestamps
    end
  end
end
