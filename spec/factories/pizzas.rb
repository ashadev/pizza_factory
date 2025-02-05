FactoryBot.define do
  factory :pizza do
    name { Faker::Food.dish }
    category { %w[vegetarian non_vegetarian].sample }
    regular_price { Faker::Number.between(from: 150, to: 250) }
    medium_price { Faker::Number.between(from: 250, to: 400) }
    large_price { Faker::Number.between(from: 400, to: 600) }
  end
end
