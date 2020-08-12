10.times do
    User.create(
        name: Faker::Name.name
        )
end

20.times do
    Recipient.create(
        name: Faker::Name.name, 
        relationship: Faker::Relationship.familial,
        birth_month: Faker::Number.between(from: 1, to: 12),
        birth_day: Faker::Number.between(from: 1, to: 28),
        user_id: Faker::Number.between(from: 1, to: 10)
        )
end

40.times do
    List.create(
        name: Faker::Color.color_name.upcase,
        recipient_id: Faker::Number.between(from: 1, to: 20)
    )
end

100.times do
    Gift.create(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price.to_i,
        description: Faker::Commerce.department,
        list_id: Faker::Number.between(from: 1, to: 40),
        gift_url: Faker::Internet.domain_name,
        img_url: Faker::Internet.domain_name
    )
end