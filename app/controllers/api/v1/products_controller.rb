module Api 
	module V1 
		class ProductsController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :authenticate
			
			def index(products = Product.all)
				render json: products
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
