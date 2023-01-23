# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
#--- cleaning database
puts 'cleaning database'
Product.destroy_all
User.destroy_all
puts 'database cleaned'

# creating users
puts 'creating user'
user1 = User.create(email: 'etest2@test.com', password: 'azerty')
puts 'user created'

# creating legos
lego_sets = [
  { title: 'Lego Star Wars',
    description: 'Millennium Falcon',
    address: '47 rue berger 75001',
    city: 'Paris',
    capacity: 7541,
    price: 849,
    start_date: Date.today,
    end_date: Date.today + 3.day,
    user: user1 },
  { title: 'Lego Tour Eiffel',
    description: 'La tour Eiffel',
    address: '5 Av. Anatole France 75007',
    city: 'Paris',
    capacity: 1000,
    price: 629,
    start_date: Date.today,
    end_date: Date.today + 3.day,
    user: user1 },
  { title: 'Lego Pyramide',
    description: 'La grande pyramide de Gizeh',
    address: '16 rue du pont neuf 75001',
    city: 'Paris',
    capacity: 1476,
    price: 600,
    start_date: Date.today,
    end_date: Date.today + 3.day,
    user: user1 },
  { title: 'Lego Maison',
    description: 'La maison en A',
    address: '9 rue mansart 75009',
    city: 'Paris',
    capacity: 3955,
    price: 299,
    start_date: Date.today,
    end_date: Date.today + 3.day,
    user: user1 },
  { title: 'Lego Voiture',
    description: 'Lamborghini Sián FKP 37',
    address: '28 rue jean de la fontaine 75016',
    city: 'Paris',
    capacity: 3696,
    price: 449,
    start_date: Date.today,
    end_date: Date.today + 3.day,
    user: user1 },
  { title: 'Lego Avion',
    description: "L'avion futuriste",
    address: '21 rue blondel 75002',
    city: 'Paris',
    capacity: 608,
    price: 119,
    start_date: Date.today,
    end_date: Date.today + 3.day,
    user: user1 },
  { title: 'Lego train',
    description: 'Le Poudlard Express',
    address: "59 bis rue jouffroy d'abbans 75017",
    city: 'Paris',
    capacity: 3750,
    price: 499,
    start_date: Date.today,
    end_date: Date.today + 3.day,
    user: user1 }
]

lego_photos = ['star_wars.jpg', 'eiffel.jpg', 'pyramide.jpg', 'maison.jpg', 'voiture.jpg', 'avion.jpg', 'train.jpg']

puts 'creating legos'
lego_sets.each_with_index do |lego_set, index|
  puts lego_set[:title]
  file = File.open(Rails.root.join("app/assets/images/#{lego_photos[index]}"))
  product = Product.new(lego_set)
  product.photo.attach(io: file, filename: lego_set[:title], content_type: "image/jpg")
  puts 'photo attached'
  product.save!
  puts 'lego created'
end
