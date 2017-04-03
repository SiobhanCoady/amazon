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


100.times do
  category = Category.all.sample
  Product.create title: Faker::Commerce.product_name,
                  description: Faker::Hipster.sentence,
                  price: Faker::Commerce.price,
                  category_id: category.id
end

products = Product.all

products.each do |p|
  rand(0..10).times do
    p.reviews.create({
      body: Faker::Friends.quote,
      rating: rand(1..5)
      })
  end
end

reviews_count = Review.count

puts Cowsay.say 'Created 100 products', :elephant
puts Cowsay.say "Created #{reviews_count} reviews", :stegosaurus



100.times do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email
end

puts Cowsay.say 'Created 100 users', :dragon
