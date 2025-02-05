FactoryBot.define do
  factory :topping do
    name {Faker::Name.name}
    category { %w[veg non_veg].sample }
    price { Faker::Number.between(from: 10, to: 50) }
  end
end
