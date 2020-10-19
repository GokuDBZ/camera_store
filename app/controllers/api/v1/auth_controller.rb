module Api 
  module V1 
		class AuthController < ApplicationController

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
          render json: {error: result.errors }
				end
			end

      def logout
				user = User.find_by_email(user.email)
				user.reset_token
				user.save
			end
			
			private

			def required_params
				params.permit(:email,:password)
			end
    end
  end
end

