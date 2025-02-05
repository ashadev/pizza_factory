class OrderSide < ApplicationRecord
  belongs_to :order
  belongs_to :side

  validates :price, presence: true, numericality: { greater_than: 0 }
end
