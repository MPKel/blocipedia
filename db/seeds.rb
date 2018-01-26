require 'faker'


5.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password123",
    password_confirmation: "password123"
  )
end

users = User.all

15.times do
  Wiki.create!(
    title: Faker::RickAndMorty.quote,
    body: Faker::Lorem.paragraph,
    private: false,
    user: users.sample
  )
end


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
