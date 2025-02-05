class CreateInventory < ActiveRecord::Migration[8.0]
  def change
    create_table :inventories do |t|
      t.integer :item_type, null: false  # 0: Pizza, 1: Topping, 2: Crust, 3: Side
      t.integer :item_id, null: false
      t.integer :quantity, null: false, default: 0
      t.timestamps
    end
  end
end
