# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Agare',
             email: 'agareefe@gmail.com',
             password: 'agareefe',
             password_confirmation: 'agareefe',
             admin: true,
             bio: 'I love what I do and I will keep doing it',
             profession: 'Admin')

10.times do |n|
  name  = Faker::Name.name
  email = "ozone2day#{n + 1}@gmail.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               bio: 'I love what I do and I will keep doing it',
               profession: 'Software Developer')
end

10.times do |n|
  name  = Faker::Name.name
  email = "agare#{n + 1}@gmail.com"
  password = 'railsworking'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               bio: 'I love what I do and I will keep doing it',
               profession: 'Civil Engineer')
end

10.times do |n|
  name  = Faker::Name.name
  email = "efe4rails#{n + 1}@gmail.com"
  password = 'victory'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               bio: 'This is me, i love what I do',
               profession: 'Electrical Engineer')
end

20.times do |n|
  name  = Faker::Name.name
  email = "regina4real#{n + 1}@gmail.com"
  password = 'knowledge'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               bio: '',
               profession: 'Fashion designer')
end
