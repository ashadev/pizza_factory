FactoryBot.define do
  factory :order_pizza do
    order
    pizza
    crust
    size { %w[regular medium large].sample }
    price { Faker::Number.between(from: 150, to: 500) }
  end
end
