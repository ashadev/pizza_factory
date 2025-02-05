class Topping < ApplicationRecord
  has_many :order_toppings
  enum :category, [ :veg, :non_veg, :extra_cheese ]

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def paneer?
    name.downcase == 'paneer'
  end
end
