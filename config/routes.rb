Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts

  match '/login', to: 'users#login', as: 'login', via: [:get, :post]
  get '/logout', to: 'users#logout', as: 'logout'
  post '/add_comment', to: 'posts#add_comment', as: 'add_comment'

  namespace :api do
    namespace :v1 do
      get '/posts', to: 'posts#index'
      get '/posts/:id', to: 'posts#show'
      post '/posts', to: 'posts#create'
      post '/posts/:id', to: 'posts#update'
      delete '/posts/:id', to: 'posts#destroy'
    end
  end
end
