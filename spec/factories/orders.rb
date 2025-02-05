FactoryBot.define do
  factory :order do
    user
    status { "pending" }
    total_price { Faker::Number.between(from: 300, to: 1000) }
  end
end
