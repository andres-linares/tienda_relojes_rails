# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

product_1 = Product.create(
  name: 'Rolex Hombre GMT (nueva colección)',
  description: 'El diseño robusto y funcional del Oyster Perpetual se convirtió rapidamente en un icono.',
  price: 59500
)
product_1.images.attach(io: File.open('clock_images/1/1.png'), filename: '1.png')
product_1.images.attach(io: File.open('clock_images/1/2.png'), filename: '2.png')
product_1.images.attach(io: File.open('clock_images/1/3.png'), filename: '3.png')

product_2 = Product.create(
  name: 'Winner Skeleton Automatico 246',
  description: 'Winner watch, nueva llegada de relojes para hombre, inspirado en el mejor estilo actual, movimiento automático de gran precisión.',
  price: 89900
)
product_2.images.attach(io: File.open('clock_images/2/1.png'), filename: '1.png')
product_2.images.attach(io: File.open('clock_images/2/2.png'), filename: '2.png')
product_2.images.attach(io: File.open('clock_images/2/3.png'), filename: '3.png')

product_3 = Product.create(
  name: 'Invicta Reserve',
  description: 'Invicta de acero inoxidable creado y manufacturado en Suiza.',
  price: 2559900
)
product_3.images.attach(io: File.open('clock_images/3/1.png'), filename: '1.png')
product_3.images.attach(io: File.open('clock_images/3/2.png'), filename: '2.png')
product_3.images.attach(io: File.open('clock_images/3/3.png'), filename: '3.png')

product_4 = Product.create(
  name: 'Fossil Gen 3 Q',
  description: 'Reloj elegante Fossil para hombres Gen 3 Q Explorist Luggage Leather',
  price: 878990
)
product_4.images.attach(io: File.open('clock_images/4/1.png'), filename: '1.png')
product_4.images.attach(io: File.open('clock_images/4/2.png'), filename: '2.png')
product_4.images.attach(io: File.open('clock_images/4/3.png'), filename: '3.png')
