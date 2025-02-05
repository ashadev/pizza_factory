FactoryBot.define do
  factory :order_topping do
    order_pizza
    topping
    price { Faker::Number.between(from: 10, to: 50) }
  end
end
