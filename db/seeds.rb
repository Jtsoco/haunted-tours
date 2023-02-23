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

def fake_user_admin(first_name, last_name)
  user = User.new
  user.email = "#{first_name}@faker.net"
  user.first_name = first_name
  user.last_name = last_name
  user.password = 'password'
  user.photo.attach(io: dwayne, filename:"Dwayne.jpg", content_type: "image/jpg" )
  puts user
  user.save
end

def fake_user
  user = User.new
  name = Faker::Name.unique.name
  first_name = name.split()[0]
  last_name = name.split()[1]
  user.email = "#{first_name}@faker.net"
  user.first_name = first_name
  user.last_name = last_name
  user.password = 'password'
  user.photo.attach(io: dwayne, filename:"Dwayne.jpg", content_type: "image/jpg" )
  puts user.full_name
  user.save
end
require 'faker'
PHOTO_ARRAY = ["https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948043/development/haunted-tours/sewer_bo51xi.avif",
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159836/development/haunted-tours/ajtlzrlsrodmmdssyipf.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159795/development/haunted-tours/images_nfh29w.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159787/development/haunted-tours/jbamqett9vtifkkio0rz.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159777/development/haunted-tours/rmwgehbdmilma5391kjf.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159777/development/haunted-tours/rmwgehbdmilma5391kjf.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159752/development/haunted-tours/swjzbjrft7ghbr6qstye.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159738/development/haunted-tours/images_d7cx8j.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1677159726/development/haunted-tours/creep_b9n0gn.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948036/development/haunted-tours/scary_kitchen_gcyshd.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948034/development/haunted-tours/haunted_house_2_iiflhg.webp',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948033/development/haunted-tours/scary_bedroom_ufjadj.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948031/development/haunted-tours/haunted_room_1_c9dtcf.jpg',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948027/development/haunted-tours/haunted_room_2_kpp9d8.webp',
  'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1676948022/development/haunted-tours/haunted_house_mnq1nv.jpg',

]
User.destroy_all
puts 'creating dummies'


fake_user_admin('luca', 'Vigotti')
fake_user_admin('kenta', 'Asakura')
fake_user_admin('emmanuel', 'de La Forest')
fake_user_admin('jackson', 'Socolofsky')
10.times do
  fake_user
end
MONSTERS = %w[demon ghost witch monster zombie murderer goblin devil skeleton]
def make_tours(index)
  4.times do
    tour = Tour.new
    location = Faker::Address.full_address
    tour_name = Faker::Address.city_prefix
    tour_prefix = Faker::Address.city_suffix
    tour.name = "The #{MONSTERS.sample}s of #{tour_prefix} #{tour_name} "
    puts tour.name
    tour.price = 666
    tour.description = Faker::Books::Lovecraft.sentence
    tour.location = location
    tour.user = User.all[index]
    3.times do
      url = PHOTO_ARRAY.sample
      type = url.split('.').last
      file = URI.open(url)
      tour.photos.attach(io: file, filename:"#{Faker::Books::Lovecraft.deity}.#{type}", content_type: "image/#{type}" )
    end
    tour.save
  end
end
puts 'making tours'
make_tours(0)
make_tours(1)
make_tours(2)
make_tours(3)
make_tours(4)
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
