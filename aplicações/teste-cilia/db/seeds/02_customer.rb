puts "Criando registro do cliente".ljust(75, "-")

customer = Customer.create!(
  name: Faker::Name.name,
  document: Faker::IdNumber.brazilian_citizen_number,
  email: "cliente1@email.com",
  password: '123456',
  password_confirmation: '123456',
)

Address.create!(
  street: Faker::Address.street_name,
  number: Faker::Address.building_number,
  district: Faker::Address.community,
  city: Faker::Address.city,
  state: Faker::Address.state_abbr,
  zipcode: Faker::Address.zip_code.delete('-'),
  customer: customer
)

Phone.create!(
  ddd: Faker::PhoneNumber.area_code,
  number: Faker::PhoneNumber.subscriber_number(length: 8),
  customer: customer
)
