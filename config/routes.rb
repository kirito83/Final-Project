Rails.application.routes.draw do
  resources :matches
  resources :tournaments
  root to: 'home#index'

  devise_for :users, controllers: {
        sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'
      }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
  	get '/sign_up', to: 'devise/registrations#new'
  	get '/sign_in', to: 'devise/sessions#new'
  	post '/sign_in', to: 'devise/sessions#create'
    get '/show', to: 'devise/sessions#show'
    get '/edit', to: 'devise/registrations#edit'
  end
end
