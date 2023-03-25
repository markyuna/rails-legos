# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
#--- cleaning database
puts 'cleaning database'
Booking.destroy_all
Product.destroy_all
User.destroy_all

# puts 'creating users'

# user_attributes = {
#   name: Faker::Internet.username,
#   email: Faker::Internet.email,
#   password: Faker::PhoneNumber.subscriber_number(length: 6)
# }
# users = User.create(user_attributes)

users = User.create!(email: 'marcos@gmail.com', password: 'esternoma', name: 'Marcos')

puts 'database cleaned'

# creating legos

lego_sets = [
  { title: 'Lego Star Wars',
    description: 'Le compartiment principal contient des sièges, un poste d’ingénierie avec un siège miniature pivotant et une entrée avec passage.',
    address: '47 rue berger 75001',
    city: 'Paris',
    capacity: 7541,
    price_per_day: 14,
    user: users
  },
  { title: 'Lego Tour Eiffel',
    description: 'Une construction comparable à nulle autre – Préparez-vous à battre des records avec le set LEGO® La tour Eiffel pour adultes.',
    address: '5 Av. Anatole France 75007',
    city: 'Paris',
    capacity: 10001,
    price_per_day: 10,
    user: users
  },
  { title: 'Lego Pyramide',
    description: 'Modèle en coupe – Soulevez la structure extérieure pour révéler le système sans doute utilisé pour déplacer les pierres lors de la construction.',
    address: '16 rue du pont neuf 75001',
    city: 'Paris',
    capacity: 1476,
    price_per_day: 12,
    user: users
  },
  { title: 'Lego Maison',
    description: 'Un grand nombre de murs et d’éléments de ce modèle peuvent être réorganisés pour créer des scènes d’action différentes.',
    address: '9 rue mansart 75009',
    city: 'Paris',
    capacity: 3955,
    price_per_day: 9,
    user: users
  },
  { title: 'Lego Voiture',
    description: 'Avec 2 moteurs à rétrofriction, cette voiture est facile à contrôler. Il suffit de la faire reculer puis de la lâcher ',
    address: '60 rue du roi de sicile 75004',
    city: 'Paris',
    capacity: 3696,
    price_per_day: 18,
    user: users
  },
  { title: 'Lego Avion',
    description: "Attache les éléments d'explosion de puissance aux mains de Super-Adaptoid puis pousse vers l'intérieur pour tirer !",
    address: '21 rue blondel 75002',
    city: 'Paris',
    capacity: 608,
    price_per_day: 10,
    user: users
  },
  { title: 'Lego train',
    description: "La locomotive, le tender à charbon et le wagon de voyageurs à 3 compartiments débordent de références au film.",
    address: "59 bis rue jouffroy d'abbans 75017",
    city: 'Paris',
    capacity: 3750,
    price_per_day: 9,
    user: users
  },
  { title: 'Le stade Santiago',
    description: "Célèbre plus de 75 ans de matchs légendaires avec l'ensemble Le stade Santiago Bernabéu du Real Madrid",
    address: "51 rue riquet 75019",
    city: 'Paris',
    capacity: 5876,
    price_per_day: 12,
    user: users
  },
  { title: 'Le Taj Mahal',
    description: "Ce superbe modèle à construire et exposer du Taj Mahal est idéal pour les passionnés d’architecture, de voyages et d’histoire.",
    address: "28 rue jean de la fontaine 75016",
    city: 'Paris',
    capacity: 2022,
    price_per_day: 14,
    user: users
  },
  { title: 'Le Colisée',
    description: "Le modèle en briques du monumental Colisée prend vie avec le kit LEGO® Le Colisée (10276), fascinante et enrichissante pour adultes.",
    address: "16 rue des martyrs 75009",
    city: 'Paris',
    capacity: 9036,
    price_per_day: 14,
    user: users
  },
  { title: 'Le Titanic',
    description: "Titanic avec cette maquette à l’échelle 1:200 du paquebot. Parmi ces détails, plus de 300 hublots, une grue de chargement et plus encore.",
    address: "35 rue de la gare 75019",
    city: 'Paris',
    capacity: 2007,
    price_per_day: 8,
    user: users
  }
]

lego_photos = ['_star_wars.jpg', '_eiffel.jpg', '_pyramide.jpg', '_maison.jpg', '_voiture.jpg', '_avion.jpg', '_train.jpg', '_stade.jpg', '_mahal2.jpg', '_colise.jpg', '_Le Titanic.jpg']

puts 'creating legos'

lego_sets.each_with_index do |lego_set, index|
  puts lego_set[:title]
  file = File.open(Rails.root.join("app/assets/images/#{lego_photos[index]}"))
  product = Product.new(lego_set)
  product.photo.attach(io: file, filename: lego_set[:title], content_type: "image/jpg")
  puts 'photo attached'
  product.save!
end
puts 'lego created'
