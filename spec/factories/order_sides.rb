FactoryBot.define do
  factory :order_side do
    order
    side
    price { Faker::Number.between(from: 50, to: 100) }
  end
end
