class OrderPizza < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  belongs_to :crust
  has_many :order_toppings, dependent: :destroy

  enum :size, [ :regular, :medium, :large ]

  validates :size, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  before_save :check_topping_limits

  private

  def check_topping_limits
    if large? && order_toppings.count > 2
      errors.add(:base, "Large pizzas come with up to 2 free toppings")
      throw :abort
    elsif order_toppings.count > 1 && !large?
      errors.add(:base, "Regular and medium pizzas allow only one topping")
      throw :abort
    end
  end
end
