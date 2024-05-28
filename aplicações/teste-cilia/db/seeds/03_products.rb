puts "Criando registros de produtos ".ljust(75, "-")

Product.create!(
  name: Faker::Commerce.product_name,
  description: Faker::Lorem.sentence,
  price: Faker::Number.decimal(l_digits: 2),
  image: Rack::Test::UploadedFile.new(Rails.root.join('public', 'uploads', 'examples', 'short.png'), 'image/png')
)

Product.create!(
  name: Faker::Commerce.product_name,
  description: Faker::Lorem.sentence,
  price: Faker::Number.decimal(l_digits: 2),
  image: Rack::Test::UploadedFile.new(Rails.root.join('public', 'uploads', 'examples', 'tshirt.png'), 'image/png')
)