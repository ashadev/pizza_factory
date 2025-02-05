class CreateOrderTopping < ActiveRecord::Migration[8.0]
  def change
    create_table :order_toppings do |t|
      t.references :order_pizza, null: false, foreign_key: true
      t.references :topping, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
