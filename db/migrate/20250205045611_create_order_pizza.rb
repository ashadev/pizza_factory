class CreateOrderPizza < ActiveRecord::Migration[8.0]
  def change
    create_table :order_pizzas do |t|
      t.references :order, null: false, foreign_key: true
      t.references :pizza, null: false, foreign_key: true
      t.references :crust, null: false, foreign_key: true
      t.integer :size, null: false  # 0: Regular, 1: Medium, 2: Large
      t.decimal :price, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
