FactoryBot.define do
  factory :sale_product do
    quantity { Faker::Number.between(from: 1, to: 10) }
    association :sale
    association :product
  end
end