class Pizza < ApplicationRecord
  has_many :order_pizzas
  enum :category, [ :vegetarian, :non_vegetarian ]

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :regular_price, :medium_price, :large_price, presence: true, numericality: { greater_than: 0 }
end
