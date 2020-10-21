# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


data = {
    nikon: {
            type: "point and shoot",
            model: 2018,
            products: [
                {name: "D780", description: "DSLR", price: 188990, make: 2019},
                {name: "Z50", description: "W/AF-P DX Nikkor 18-55mm f/3.5-5.6G VR", price: 65000, make: 2018}
            ]
        },
    canon: {
            type: "full frame",
            model: 2019,
            products: [
                {name: "EOS M200", description: "EF-M 15-45mm f/3.5-6.3 is STM Lens", price: 38900, make: 2019},
                {name: "EOS 3000D", description: "Single Kit with 18-55 lens", price: 19999, make: 2019}
        ]
    }
}.with_indifferent_access


user_data = [{email: "srj@gmail.com", password: "password"},
             {email: "srj1@gmail.com", password: "SRJ009#^%"}
            ]
user_data.each do |ud|
    User.create(ud)
end



# data.keys.each do |key|
#     byebug
#     cat = Category.new
#     cat.name = key
#     cat.category_type = data[key][:type]
#     cat.model = data[key][:model]
#     cat.save

#     data[key][:products].each do |product|
#         prod = Product.new
#         prod.name = product[:name]
#         prod.description = product[:description]
#         prod.price = product[:price]
#         prod.make = product[:make]
#         prod.category_id = cat.id
#         prod.save
#     end
# end
