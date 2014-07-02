namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Exemplo Usuário",
                 email: "exemplo@saci.com",
                 password: "senha6",
                 password_confirmation: "senha6")
    99.times do |n|
      name  = Faker::Name.name
      email = "exemplo-#{n+1}@saci.com"
      password  = "senha6"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end