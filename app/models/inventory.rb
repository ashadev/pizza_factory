class Inventory < ApplicationRecord
  belongs_to :user
  enum :item_type, [ :pizza, :topping, :crust, :side ]

  validates :item_type, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
