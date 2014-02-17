TOERH::Application.routes.draw do
  get "licences/api/v1/resource_types"
  get "licences/rails"
  get "licences/g"
  get "licences/controller"
  get "licences/api/v1/licences"
  get "resources/api/v1"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'api_key#index'

  post 'generate' => 'api_key#generate', as: :generate

  resources :admin

  get 'login' => 'auth#index', as: :showLogin
  post 'login' => 'auth#login', as: :login
  get 'logout' => 'auth#logout', as: :logout

  namespace :api do
    namespace :v1 do
      resources :resources
      resources :licences
      resources :resourcetypes
      resources :users do
        resources :resources
      end 
    end
  end 
end
