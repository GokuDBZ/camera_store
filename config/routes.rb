Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, path: "api" do
    namespace :v1, path: "v1" do
      post "/signup", to: "auth#signup"

      resources :categories, only: [:index] do
        get 'products'
      end
      
      resources :products, only: [:index]

      resources :carts, only: [:show] do
        collection do
          post "add_product"
        end
      end
    end
  end
end
