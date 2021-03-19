namespace :utils do
  desc "TODO"
  task seed: :environment do

    print "Gerando os contatos aleatórios..."
    50.times do |i|
      Contato.create!(
        nome: Faker::Name.name,
        email: Faker::Internet.email,
        tipo: Tipo.all.sample,
        observacao: Faker::Lorem.paragraph(sentence_count: 2)
      )
    end
    puts "[OK]"

    print "Gerando os endereços aleatórios..."
    Contato.all.each do |contato|
      Endereco.create!(
        endereco: Faker::Address.street_address,
        cidade: Faker::Address.city,
        estado: Faker::Address.state,
        contato: contato
      )
    end
    puts "[OK]"

    print "Gerando os telefones aleatórios..."
    Contato.all.each do |contato|
      Random.rand(1..3).times do |i|
        numero = Faker::PhoneNumber.cell_phone
        
        Telefone.create!(
          ddd: /\d{2}/.match(numero).to_s.to_i,
          numero: /\d{5}-\d{4}/.match(numero).to_s.gsub(/-/, "").to_i,
          contato: contato
        )
      end
    end
    puts "[OK]"

  end

end
