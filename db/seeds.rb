# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Brand.create([
  { name: 'Rollex' },
  { name: 'Armani' },
  { name: 'Fossil' },
  { name: 'Tissot' },
  { name: 'Wenger' },
  { name: 'Casio' },
  { name: 'Invicta' },
  { name: 'BMW' },
  { name: 'Tommy Hilfiger' },
  { name: 'Q&Q' },
  { name: 'Calvin Klein' },
  { name: 'Diesel' },
  { name: 'Certina' },
  { name: 'G-Shock' },
  { name: 'Michael Kors' },
])

product_1 = Product.create(
  name: 'T-Race',
  description: 'El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por el deporte del motor se está acelerando en el carril rápido de la moda.',
  price: 2706000,
  brand: Brand.find_by_name('Tissot')
)
product_1.images.attach(io: File.open('clock_images/1/1.jpg'), filename: '1.jpg')
product_1.images.attach(io: File.open('clock_images/1/2.jpg'), filename: '2.jpg')
product_1.images.attach(io: File.open('clock_images/1/3.jpg'), filename: '3.jpg')
