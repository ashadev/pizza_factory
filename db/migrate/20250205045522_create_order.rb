class CreateOrder < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0, null: false  # 0: Pending, 1: Confirmed, 2: Delivered, 3: canceled
      t.decimal :total_price, precision: 10, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end
