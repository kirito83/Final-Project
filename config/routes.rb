Rails.application.routes.draw do
  resources :categories
  resources :matches
  resources :tournaments do
    post 'suscribe', on: :member
    post 'unsuscribe', on: :member
  end
  resources :products
  root to: 'home#index'

  devise_for :users, controllers: {
        sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'
      }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
  	get '/sign_up', to: 'devise/registrations#new'
  	get '/sign_in', to: 'devise/sessions#new'
  	post '/sign_in', to: 'devise/sessions#create'
    delete '/sign_out', to: 'devise/sessions#destroy'
    get '/show', to: 'devise/sessions#show'
    get '/edit', to: 'devise/registrations#edit'
  end

  get '/index/mail', to: 'home#send_email'
end
