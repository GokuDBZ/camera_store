require 'rails_helper'
RSpec.describe Api::V1::CartsController do
  describe "Categories API" do
    before(:each) do
        # Not creating data with Factory Bot for now, using seed data
        @cat  = Category.new.tap do |cat|
                    cat.category_type = "point and shoot"
                    cat.name = "Nikon"
                    cat.model = 2018
                    cat.save
                end

        @prod = Product.new.tap do |prod|
                    prod.category_id = @cat.id
                    prod.name = "D780"
                    prod.description = "DSLR"
                    prod.price = 188990
                    prod.make = 2019
                    prod.save
                end
        @user = User.create({email: "suraj@test.com", password: "password"})
    end

    after(:each) do
        DatabaseCleaner.clean
    end

    it "Should add product to cart" do
        request.headers['Authorization'] = "Bearer #{@user.token}"
        post 'add_product', params: {product_id: @prod.id, category_id: @cat.id}
        
        _response = JSON.parse(response.body)

        expect(_response["cart_items"].count).to eq(1)
       
    end

  end
end