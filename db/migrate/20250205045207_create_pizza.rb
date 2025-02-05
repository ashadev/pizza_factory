class CreatePizza < ActiveRecord::Migration[8.0]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.index :name, unique: true
      t.integer :category, null: false  # 0: Vegetarian, 1: Non-Vegetarian
      t.decimal :regular_price, precision: 10, scale: 2, null: false
      t.decimal :medium_price, precision: 10, scale: 2, null: false
      t.decimal :large_price, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
