class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.references :customer, null: false, foreign_key: {to_table: :customers}
      t.references :home_food, null: false, foreign_key: {to_table: :home_foods}
      t.boolean :read, null: false, default: false
      t.string :message, null: false
      t.string :notification_type, null: false

      t.timestamps
    end
  end
end
