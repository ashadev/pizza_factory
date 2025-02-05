class CreateOrderSide < ActiveRecord::Migration[8.0]
  def change
    create_table :order_sides do |t|
      t.references :order, null: false, foreign_key: true
      t.references :side, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
