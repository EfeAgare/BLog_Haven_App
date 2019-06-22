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
             profession: 'Admin',
             activated: true,
             activated_at: Time.zone.now)

10.times do |n|
  name  = Faker::Name.name
  email = "ozone2day#{n + 1}@gmail.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               bio: 'I love what I do and I will keep doing it',
               profession: 'Software Developer',
               activated: true,
               activated_at: Time.zone.now)
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
               profession: 'Civil Engineer',
               activated: true,
               activated_at: Time.zone.now)
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
               profession: 'Electrical Engineer',
               activated: true,
               activated_at: Time.zone.now)
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
               profession: 'Fashion designer',
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
10.times do
  content = Faker::Lorem.sentence(70)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
