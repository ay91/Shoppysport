# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "admin",
             email: "admin@shoppysport.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             )

10.times do |n|
  name = "user#{n}"
  email = "user#{n}@shoppysport.com"
  password = "foobar"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               admin: false,
               )
end

Category.create!(name: "Badminton")
Category.create!(name: "Tennis")
Category.create!(name: "Men")

categories = Category.all

20.times do
  title = ['Yonex', 'Z-Force', 'Arch-Saber', 'Li Ning', 'Victor', 'Nanoray-Z', 'Voltric Force', 'Carlton', 'EZone', 'VCore', 'VCore Duel', 'Nanospeed', 'Titanium']
  price = rand(100..300)
  image =  [File.new("#{Rails.root}/app/assets/images/racket-1.jpg"), File.new("#{Rails.root}/app/assets/images/racket-2.jpg"), File.new("#{Rails.root}/app/assets/images/racket-3.jpg"), File.new("#{Rails.root}/app/assets/images/men-1.jpg"), File.new("#{Rails.root}/app/assets/images/men-2.jpg"), File.new("#{Rails.root}/app/assets/images/men-3.jpg"),
     File.new("#{Rails.root}/app/assets/images/tennis-1.jpg"), File.new("#{Rails.root}/app/assets/images/tennis-2.jpg"), File.new("#{Rails.root}/app/assets/images/tennis-3.jpg")]
  categories.each do |category|
    category.items.create!(title: title[rand(title.length)],
                          price: price,
                          image: image[rand(image.length)]
                          )
  end
end
