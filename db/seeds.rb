# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# dwayne is just the dwayne johnson profile pic
def dwayne
  user_url = 'https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459847/seeds/haunted%20tours/3bdb2575-9a92-42f8-8472-bb78c7bd118a_720x405_y0qjpx.jpg'
  URI.open(user_url)
end

def fake_user_admin(first_name, last_name)
  user = User.new
  user.email = "#{first_name}@faker.net"
  user.first_name = first_name.capitalize
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
PHOTO_ARRAY = [ "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459843/seeds/haunted%20tours/EUtkgapXYAc3Wpk_thkg8c.jpg",
  "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459841/seeds/haunted%20tours/haunted_travel_destinations_spooky_vacations_400_1_pshjp3.jpg",
  "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459835/seeds/haunted%20tours/download_dq3tas.jpg",
  "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459233/seeds/haunted%20tours/haunted_house_2_v06kfq.webp",
  "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459834/seeds/haunted%20tours/haunted-house-g5d638e7bd_1920_1667132286906_1667132303445_1667132303445_jacftj.webp",
  "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459231/seeds/haunted%20tours/scary_kitchen_rg4bkv.jpg",
  "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459230/seeds/haunted%20tours/scary_bedroom_d65sfp.jpg",
  "https://res.cloudinary.com/dfjkxrkvj/image/upload/v1679459229/seeds/haunted%20tours/haunted_room_1_gv9hat.jpg"

]
User.destroy_all
puts 'creating dummies'


fake_user_admin('luca', 'Vigotti')
fake_user_admin('kenta', 'Asakura')
fake_user_admin('emmanuel', 'de La Forest')
fake_user_admin('jackson', 'Socolofsky')

REVIEW_SAMPLES = ["I loved it!", "It was fine.", "I think someone is faking reviews, NOT 5 coffins out of five.",
"Horrific, literally scared the shit out of me. Would go again after buying new pants.", "Something jumped at me and I dropped my coffee ):",
"Tour guide was great, good energy and charisma.", "My favorite haunted tour any time of the year"]

def description_template(hash = {})
  "Come one and all to a frightful tour of #{hash[:name]}!
  We'll deal with all manner of frightful paranormal activity. This tour in particular will focus
  on the #{hash[:monster]} that roam the abandoned graveyards, forests, and manors of #{hash[:name]}. Stay close, and
  hold your flashlight closer. I'll be giving tours from #{hash[:num1]}:00 to #{hash[:num2]}:00 AM. Only #{hash[:price]} per person!
  Come now before it's too late, and have the fright of your life at #{hash[:user_name]}'s haunted tours!"
end


MONSTERS = %w[demons ghosts witches monsters zombies murderers goblins devils skeletons]

def make_tours(index)
  4.times do
    numb1 = 19
    numb2 = rand(1..6)
    tour = Tour.new
    location = Faker::Address.full_address
    tour_name = Faker::Address.city.split.first.capitalize
    tour_prefix = Faker::Address.city_suffix.capitalize
    tour_full_name = "#{tour_prefix} #{tour_name}"
    monster_name = MONSTERS.sample
    tour.name = "#{monster_name.capitalize} of #{tour_full_name} "
    puts tour.name
    tour.price = 666
    tour.user = User.all[index]
    tour.description = description_template(name: tour_full_name, monster: monster_name, num1: numb1,
       num2: numb2, price: tour.price, user_name: tour.user.first_name.capitalize)
    tour.location = location
    urls = PHOTO_ARRAY.shuffle
    5.times do
      url = urls.pop
      type = url.split('.').last
      file = URI.open(url)
      tour.photos.attach(io: file, filename:"#{Faker::Books::Lovecraft.deity}.#{type}", content_type: "image/#{type}" )
    end
    tour.save
  end
end

4.times do |i|
  make_tours(i)
end

def booking(user, tour)
  book = Booking.new
  book.start_date = DateTime.new(2023,rand(3..12),rand(1..28),rand(19..24))
  book.user = user
  book.tour = tour
  book.guests = rand(1..10)
  book.save
end

3.times do |i|
  booking(User.all[i + 1], Tour.all[i])
end

booking(User.all[0], Tour.all[5])

10.times do
  fake_user
end

def past_booking(user, tour)
  book = Booking.new
  book.start_date = DateTime.new(2023,1,rand(1..28),rand(19..24))
  book.user = user
  book.tour = tour
  book.guests = rand(1..10)
  book.save
end

puts 'making tours and past bookings'
# make_tours(0)
past_booking(User.all[1], Tour.all[0])
# make_tours(1)
past_booking(User.all[2], Tour.all[0])
# make_tours(2)
past_booking(User.all[3], Tour.all[0])
# make_tours(3)
past_booking(User.all[4], Tour.all[0])
# make_tours(4)
past_booking(User.all[5], Tour.all[0])
# make_tours(5)
past_booking(User.all[6], Tour.all[0])
puts "making bookings"


def review(user, tour)
  rev = Review.new
  rev.comment = REVIEW_SAMPLES.sample
  rev.time = DateTime.new(2023,2,rand(1..28),rand(6..10))
  rev.user = user
  rev.tour = tour
  rev.save
end

puts "Making reviews"

6.times do |i|
review(User.all[i], Tour.all[0])
end

6.times do |i|
  review(User.all[i], Tour.all[2])
end


puts "Making regular bookings"

5.times do |i|
  x = 1
  puts "Five bookings for #{User.all[x]}"
  7.times do
    booking(User.all[x], Tour.all[i])
    x += 1
  end
end
Tour.all.each do |tour|
  booking(User.last, tour)
end

puts "finished"
