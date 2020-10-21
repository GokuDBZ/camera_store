module Api 
  module V1 
		class UsersController < ApplicationController
			before_action :authenticate!, if: :valid_actions?
			include ActionController::HttpAuthentication::Token::ControllerMethods
			
			

			def login
				user = User.find_by_email(params[:email])
				
				if user.present?
						render json: {access_token: user.token, email: user.email}
				else
						render json: {error: "No user is registered with email #{params[:email]}"}
				end
			end
		
			def signup
				byebug
				data = required_params
				user = User.new(data)
				result = user.save
				if result
						render json: {email: user.email, access_token: user.token}
				else
						render json: {error: user.errors }
				end
			end
		
			def logout
				user = User.find_by_email(user.email)
				user.reset_token
				user.save
			end

			def cart
				byebug
				cart = current_user.cart
				render json: {cart: cart.cart_items}
		  end

			private

			def valid_actions?
			  params["action"] == "cart"	
			end

			def authenticate!
				authenticate_or_request_with_http_token do |token, _options|
					User.find_by(token: token)
				end
			end

			
			def current_user
				@current_user ||= authenticate!
			end

			def required_params
				params.permit(:email,:password)
			end
		end
  end
end

