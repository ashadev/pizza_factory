FactoryBot.define do
  factory :side do
    name { Faker::Name.name }
    price { Faker::Number.between(from: 50, to: 100) }
  end
end
