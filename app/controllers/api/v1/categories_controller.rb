module Api 
  module V1 
		class CategoriesController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :authenticate
			
			def index(categories = Category.all)
				byebug
				render json: categories
			end

			def products
				byebug
				category = Category.find(params[:category_id])
				products = category.products
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