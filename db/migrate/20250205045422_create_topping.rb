class CreateTopping < ActiveRecord::Migration[8.0]
  def change
    create_table :toppings do |t|
      t.string :name
      t.integer :category, null: false  # 0: Veg, 1: Non-Veg, 2: Extra Cheese
      t.decimal :price, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
