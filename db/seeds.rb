# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# dwayne is just the dwayne johnson profile pic
def dwayne
  user_url = 'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676952908/development/haunted-tours/dwayne_ub4jwa.jpg'
  URI.open(user_url)
end

def fake_user_admin(name)
  user = User.new
  user.email = "#{name}@faker.net"
  user.first_name = name
  user.last_name = name
  user.password = 'password'
  user.photo.attach(io: dwayne, filename:"Dwayne.jpg", content_type: "image/jpg" )
  puts user
  user.save
end

def fake_user
  user = User.new
  name = Faker::Name.unique.name
  name = name.split()[0]
  user.email = "#{name}@faker.net"
  user.first_name = name
  user.last_name = name
  user.password = 'password'
  user.photo.attach(io: dwayne, filename:"Dwayne.jpg", content_type: "image/jpg" )
  puts user
  user.save
end
require 'faker'
photo_array = ["https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948043/development/haunted-tours/sewer_bo51xi.avif",
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948040/development/haunted-tours/haunted-tokyo-tours_ayjryz.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948036/development/haunted-tours/scary_kitchen_gcyshd.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948034/development/haunted-tours/haunted_house_2_iiflhg.webp',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948033/development/haunted-tours/scary_bedroom_ufjadj.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948031/development/haunted-tours/haunted_room_1_c9dtcf.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948027/development/haunted-tours/haunted_room_2_kpp9d8.webp',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948022/development/haunted-tours/haunted_house_mnq1nv.jpg',

]
User.destroy_all
puts 'creating dummies'


10.times do
  fake_user
end
fake_user_admin('luca')
fake_user_admin('kenta')
fake_user_admin('emmanuel')
fake_user_admin('jackson')
puts 'making tours'

12.times do
  tour = Tour.new
  location = Faker::Books::Lovecraft.location
  tour.name = "The #{location} place"
  puts tour.name
  tour.price = 666
  tour.description = Faker::Books::Lovecraft.sentence
  tour.location = location
  tour.user = User.first
  3.times do
    url = photo_array.sample
    type = url.split('.').last
    file = URI.open(url)
    tour.photos.attach(io: file, filename:"#{Faker::Books::Lovecraft.deity}.#{type}", content_type: "image/#{type}" )
  end
  tour.save
end

puts "making bookings"

def booking(user, tour)
  book = Booking.new
  book.start_date = DateTime.new(2023,rand(3..12),rand(1..28),rand(1..22))
  book.end_date = DateTime.new(2023,book.start_date.month,book.start_date.day, book.start_date.hour + 2)
  book.user = user
  book.tour = tour
  book.guests = rand(1..10)
  book.save
end

5.times do |i|
  x = 1
  puts "Five bookings for #{User.all[x]}"
  5.times do
    booking(User.all[x], Tour.all[i])
    x += 1
  end
end

puts "finished"
