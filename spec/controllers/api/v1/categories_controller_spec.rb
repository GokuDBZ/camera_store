require 'rails_helper'
RSpec.describe Api::V1::CategoriesController do
  describe "Categories API" do
    before(:each) do
        # Not creating data with Factory Bot for now, using seed data
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

        data.keys.each do |key|
            cat = Category.new
            cat.name = key
            cat.category_type = data[key][:type]
            cat.model = data[key][:model]
            cat.save

            data[key][:products].each do |product|
                prod = Product.new
                prod.name = product[:name]
                prod.description = product[:description]
                prod.price = product[:price]
                prod.make = product[:make]
                prod.category_id = cat.id
                prod.save
            end
        end
        @user = User.new.tap do |user|
                  user.email = "prem2@gmail.com"
                  user.password = "password"
                  user.save
                end
    end

    after(:each) do
        DatabaseCleaner.clean
    end


    it "List All Categories" do
        request.headers['Authorization'] = "Bearer #{@user.token}"
        get 'index'
        _response = JSON.parse(response.body)
        expect(_response.class).to eq(Array)
    end

    it "Should not List categories if token is invalid" do
        old_token = @user.token
        @user.reset_token
        
        new_token = @user.token

        request.headers['Authorization'] = "Bearer #{old_token}"
        get 'index'
        expect(response.body).to eq("HTTP Token: Access denied.\n")
       
    end

  end
end