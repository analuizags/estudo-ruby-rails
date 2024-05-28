puts "Criando registro do admin ".ljust(75, "-")

Admin.create!(
  email: "admin@email.com",
  password: "123456",
  password_confirmation: "123456"
)