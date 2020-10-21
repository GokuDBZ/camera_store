require 'swagger_helper'


describe 'Auth SignUp' do
    path "/api/v1/users/signup" do
        post 'Sign Up a User' do
            tags 'Sign Up'
            consumes 'application/x-www-form-urlencoded'
            produces 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    email: {type: :string},
                    password: {type: :string}
                },
                required: ['email', 'password']
            }
    
            response '200', 'user created' do
                schema type: :object,
                       properties: {
                           email: {type: :string},
                           access_token: {type: :string}
                       } 
                let(:user) { { email: 'srj@gmail.com', password: "password" } }
                run_test!
            end
        end
    end

    path "/api/v1/users/login" do
        post 'LogIn a User' do
            tags 'Log In'
            consumes 'application/x-www-form-urlencoded'
            produces 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    email: {type: :string},
                    password: {type: :string}
                },
                required: ['email', 'password']
            }
    
            response '200', 'user login' do
                schema type: :object,
                       properties: {
                           email: {type: :string},
                           access_token: {type: :string}
                       } 
                let(:user) { { email: 'srj@gmail.com', password: "password" } }
                run_test!
            end
        end
    end

    path "/api/v1/users/{id}/cart" do
        get 'Get cart of specific user' do
            tags 'Get cart of specific user'
            consumes 'application/x-www-form-urlencoded'
            produces 'application/json'
            parameter name: :id, in: :path, schema: {
                type: :integer,
            }
    
            response '200', 'user cart' do
                examples 'application/json' => {
                    id: 1,
                    title: "hello"
                }
                run_test!
            end
            security [ bearer_auth: [] ]
        end
    end
    
end

describe 'Categories' do
    path "/api/v1/categories" do
        get 'List down all categories' do
            tags 'Categories'
            produces 'application/json'
            
    
            response '200', 'categories listed' do
                schema type: :array,
                       items: {type: :object,
                       properties: {
                        id: {type: :string},
                        name: {type: :string},
                        category_id: {type: :integer},
                        description: {type: :string},
                        price: {type: :string},
                        model: {type: :int}
                    }
                       }
                        
                
                run_test!
            end
            security [ bearer_auth: [] ]
        end
    end

    path "/api/v1/categories/{categoryId}/products" do
        get 'List down all products in a category' do
            tags 'List down all products in a category'
            produces 'application/json'
            
            parameter name: :categoryId, in: :path, schema: {
                type: :integer,
            }
            response '200', 'categories listed' do
                schema type: :array,
                        items: {type: :object,
                        properties: {
                        id: {type: :string},
                        name: {type: :string},
                        category_id: {type: :integer},
                        description: {type: :string},
                        price: {type: :string},
                        model: {type: :int}
                    }
                        }
                        
                
                run_test!
            end
            security [ bearer_auth: [] ]
        end
    end
    
end

describe 'Products' do
    path "/api/v1/products" do
        get 'List down all products' do
            tags 'products'
            produces 'application/json'
            
    
            response '200', 'Products listed' do
                schema type: :array,
                       items: {type: :object,
                       properties: {
                        id: {type: :integer},
                        name: {type: :string},
                        category_id: {type: :integer},
                        description: {type: :string},
                        price: {type: :string},
                        make: {type: :int}
                    }
                       }
                        
                
                run_test!
            end
            security [ bearer_auth: [] ]
        end
    end
    
end

describe 'User Cart' do
    after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
      end
    path "/api/v1/carts/add_product" do
        post 'Add Product to userCart' do
            tags 'Add Product to user cart'
            consumes 'application/json'
            produces 'application/json'
            
            parameter name: :user_cart, in: :body, schema: {
                type: :object,
                properties: {
                    product_id: {type: :integer},
                    quantity: {type: :integer}
                },
                required: ['product_id', 'quantity']
            }

            response 200, 'Product Added' do
                examples 'application/json' => {
                    id: 1,
                    title: "hello"
                }
                after do |example|
                    example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
                end        
                run_test!
            end
            security [ bearer_auth: [] ]
        end
    end
end

# cart_items: [
#                         {
#                           id: 2,
#                           cart_id: 6,
#                           user_id: 11,
#                           product_id: 1,
#                           quantity: 1
#                         }
#                     ]