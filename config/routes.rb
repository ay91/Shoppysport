Rails.application.routes.draw do
  get 'search/index'

  get 'items/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_scope :user do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end
  root to: 'home#index'
  get '/home', to: 'home#index'

  resources :categories do
    resources :items, only: [:index, :show]
  end

  resources :checkout, only: [:create, :new, :show]

  get '/items/all', to: "items#all_items"
  get '/search', to: "search#index"
  get :cart, to: 'cart#show'
  post :add_item, to: 'cart#add_item'
  post :update_item, to: 'cart#update_item'
  post :remove_item, to: 'cart#remove_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
end
