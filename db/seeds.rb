# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
photo_array = ["https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948043/development/haunted-tours/sewer_bo51xi.avif",
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948040/development/haunted-tours/haunted-tokyo-tours_ayjryz.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948036/development/haunted-tours/scary_kitchen_gcyshd.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948034/development/haunted-tours/haunted_house_2_iiflhg.webp',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948033/development/haunted-tours/scary_bedroom_ufjadj.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948031/development/haunted-tours/haunted_room_1_c9dtcf.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948027/development/haunted-tours/haunted_room_2_kpp9d8.webp',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948022/development/haunted-tours/haunted_house_mnq1nv.jpg'
]
Booking.destroy_all
Tour.destroy_all
User.destroy_all
puts 'creating dummies'
user_url = 'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676952908/development/haunted-tours/dwayne_ub4jwa.jpg'
10.times do
  user = User.new
  name = Faker::Name.unique.name
  name = name.split()[0]
  user.email = "#{name}@faker.net"
  user.first_name = name
  user.last_name = name
  user.password = 'password'
  file = URI.open(user_url)
  user.photo.attach(io: file, filename:"Dwayne.jpg", content_type: "image/jpg" )
  puts user
  user.save
end
puts 'making tours'

4.times do
  tour = Tour.new
  location = Faker::Books::Lovecraft.unique.location
  tour.name = "The #{location} place"
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
puts "finished"
