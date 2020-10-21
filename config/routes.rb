Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, path: "api" do
    namespace :v1, path: "v1" do
      #post "/signup", to: "users#signup"
      resources :users, only: [:show] do
        collection do
          post "signup"
          post "login"
          
        end
        get "cart"
      end

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
