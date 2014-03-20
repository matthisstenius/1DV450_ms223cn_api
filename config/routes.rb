TOERH::Application.routes.draw do
  root 'api_key#index'

  post 'generate' => 'api_key#generate', as: :generate

  get 'docs' => 'documents#index'
  resources :admin, only: [:index, :destroy]

  get 'login' => 'auth#index', as: :showLogin
  post 'login' => 'auth#login', as: :login
  get 'logout' => 'auth#logout', as: :logout

  namespace :api do
    namespace :v1 do
      resources :resources, only: [:index, :show]
      
      post 'authenticate' => 'auth#authenticate'

      resources :licences, only: [:index, :show] do 
        resources :resources, only: :index
      end

      resources :resourcetypes, only: [:index, :show] do
        resources :resources, only: :index
      end

      resources :users, only: [:index, :show, :create, :update, :destroy] do
        resources :resources, only: [:index, :show, :create, :update, :destroy]
      end 
    end
  end 

  match "*path", to: "application#options", via: :options
  #match "*path", to: "errors#catch_404", via: :all
end
