class Cart < ApplicationRecord
	has_many :cart_items
	belongs_to :user

	def self.add_product(user_id, product_id, quantity)
		response = {}
		begin
			user = User.find(user_id)
			raise "Please Login. User not Found" unless user.present?
			cart_item = CartItem.where(cart_id: user.cart_id, product_id: product_id).first
			if cart_item.present?
				cart_item.quantity += quantity if quantity > 0
				cart_item.save 
			else
				CartItem.create(cart_id: user.cart_id, user_id: user.id, product_id: product_id)
			end
			response[:message] = "Product added to cart"
		rescue => e
      response[:error] = e.massage
		end
    response
	end
end
