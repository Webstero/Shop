8.times do
  Category.create! name: Faker::Hacker.ingverb.capitalize
end

category_ids = Category.pluck(:id)

print "Product "
200.times do
  product = Product.create! name: "#{Faker::Hacker.verb} #{Faker::Hacker.noun}".capitalize,
    description: Faker::Hacker.say_something_smart,
    long_description: Faker::Lorem.paragraphs(3).join("\n\n"),
    category_id: category_ids.sample,
    price: Faker::Number.decimal(l_digits: 3, r_digits: 2)
  product.photo = Faker::Avatar.image(slug: product.name.parameterize, size: "640x480", format: "jpg", set: "set1", bgset: "bg1")
  #   product.name.parameterize,
  #   "640x480",
  #   "jpg",
  #   "set#{[1, 2, 3].sample}",
  #   "bg#{[1, 2].sample}"
  # )
  product.save!
  print "."
end
puts