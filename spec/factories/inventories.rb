# spec/factories/inventories.rb
FactoryBot.define do
  factory :inventory do
    association :user
  end
end
