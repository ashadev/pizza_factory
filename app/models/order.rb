class Order < ApplicationRecord
  belongs_to :user
  has_many :order_pizzas, dependent: :destroy
  has_many :order_sides, dependent: :destroy
  has_many :pizzas, through: :order_pizzas
  has_many :order_toppings, through: :order_pizzas

  enum :status, [ :pending, :confirmed, :delivered, :canceled ]

  before_save :validate_business_rules

  private

  def validate_business_rules
    order_pizzas.each do |order_pizza|
      if order_pizza.pizza.vegetarian? && order_pizza.order_toppings.any? { |t| t.topping.non_veg? }
        errors.add(:base, "Vegetarian pizza cannot have non-vegetarian toppings")
        throw :abort
      end

      if order_pizza.pizza.non_vegetarian? && order_pizza.order_toppings.any? { |t| t.topping.paneer? }
        errors.add(:base, "Non-vegetarian pizza cannot have paneer topping")
        throw :abort
      end
    end
  end
end
