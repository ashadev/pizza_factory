class OrderTopping < ApplicationRecord
  belongs_to :order_pizza
  belongs_to :topping

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
