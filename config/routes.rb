Rails.application.routes.draw do
  get 'items/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_scope :user do
    get "/users/sign_out", :to => "devise/sessions#destroy" 
  end
  root to: 'home#index'
  get '/home', to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
end
