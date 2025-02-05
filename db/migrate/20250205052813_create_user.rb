class CreateUser < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.index :email, unique: true
      t.string :password_digest, null: false
      t.boolean :admin, default: false  # 'admin' field to indicate if the user is an admin
      t.string :name
      t.timestamps
    end

    add_reference :orders, :user, foreign_key: true, null: false
    add_reference :inventories, :user, foreign_key: true, null: false
  end
end
