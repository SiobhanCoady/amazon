Category.create(
  [
    {name: 'Computers'},
    {name: 'Phones'},
    {name: 'Books'},
    {name: 'Artwork'},
    {name: 'Furniture'},
    {name: 'Music'}
  ]
)

25.times do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: '12345678',
              password_confirmation: '12345678'
end
puts Cowsay.say 'Created 100 users', :dragon

100.times do
  category = Category.all.sample
  user = User.all.sample
  Product.create title: Faker::Commerce.product_name,
                  description: Faker::Hipster.sentence,
                  price: Faker::Commerce.price,
                  category_id: category.id,
                  user_id: user.id
end

products = Product.all

products.each do |p|
  rand(0..10).times do
    user = User.all.sample
    p.reviews.create({
      body: Faker::Friends.quote,
      rating: rand(1..5),
      user_id: user.id
      })
  end
end

reviews_count = Review.count

puts Cowsay.say 'Created 100 products', :elephant
puts Cowsay.say "Created #{reviews_count} reviews", :stegosaurus
