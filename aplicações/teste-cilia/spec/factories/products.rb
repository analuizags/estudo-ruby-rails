FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Number.decimal(l_digits: 2) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png') }
  end
end