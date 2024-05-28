FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    document { Faker::IdNumber.brazilian_citizen_number }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    active { true }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }

    factory :customer_with_addresses do
      transient do
        addresses_count { 2 }
      end

      after(:create) do |customer, evaluator|
        create_list(:address, evaluator.addresses_count, customer: customer)
      end
    end
  end
end