# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
Booking.destroy_all
Tour.destroy_all
User.destroy_all
puts 'creating dummies'
10.times do
  user = User.new
  name = Faker::Name.unique.name
  name = name.split()[0]
  user.email = "#{name}@faker.net"
  user.first_name = name
  user.last_name = name
  user.password = 'password'
  puts user
  user.save
end
puts 'making tours'
tour = Tour.new
tour.name = "spooky house!!"
tour.price = 500
tour.description = "It's really scary I promise!"
tour.user = User.first
tour.save
