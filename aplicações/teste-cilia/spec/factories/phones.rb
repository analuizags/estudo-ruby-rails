FactoryBot.define do
  factory :phone do
    ddd { Faker::PhoneNumber.area_code }
    number { Faker::PhoneNumber.subscriber_number(length: 8) }
    association :customer, factory: :customer
  end
end
