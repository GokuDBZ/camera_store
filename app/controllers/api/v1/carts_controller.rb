module Api 
	module V1 
		class CartsController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :authenticate
			
			def add_product
				result = Cart.add_product(current_user.id, params[:product_id], params[:quantity])
				if result[:error].present?
          render json: {error: result[:error]}
				else
          render json: {email: curren_user.email, message: "Item added to Cart"}
				end
			end
			
			def show
				render json: current_user.cart.cart_items
			end

			private
			def authenticate
				authenticate_or_request_with_http_token do |token, _options|
					User.find_by(token: token)
				end
			end

			def current_user
				@current_user ||= authenticate
			end

	  end
	end
end
