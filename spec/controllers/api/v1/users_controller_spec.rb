require 'rails_helper'
RSpec.describe Api::V1::UsersController do
  describe "User Sign Up and Log In" do

    it "Sign Up user" do
      post :signup, :params =>  { :email => 'test1@gmail.com', :password => 'password' }
      expect(response).to have_http_status(:success)
      _response = JSON.parse(response.body)
      expect(_response["email"]).to eq("test1@gmail.com")
      expect(_response["access_token"]).not_to be_empty
    end

    it "User should not signp with existing email" do
        user = User.create({email: "test2@gmail.com", password: "password"})
        post :signup, :params =>  { :email => 'test2@gmail.com', :password => 'password' }

        _response = JSON.parse(response.body)
        expect(_response["error"]["email"].first).to eq("has already been taken")
    end

    it "Sign in a User" do
        user = User.create({email: "test2@gmail.com", password: "password"})
        post :login, :params =>  { :email => 'test2@gmail.com', :password => 'password' }
        _response = JSON.parse(response.body)
        expect(_response["email"]).to eq("test2@gmail.com")
        expect(_response["access_token"]).not_to be_empty
    end
    
    it "Unregistered user should not be able to login" do
        post :login, :params =>  { :email => 'test3@gmail.com', :password => 'password' }
        _response = JSON.parse(response.body)
        expect(_response["error"]).to eq("No user is registered with email test3@gmail.com")
    end

  end
end
