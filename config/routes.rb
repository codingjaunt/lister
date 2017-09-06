Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'public_pages#home'
  get '/home/show', to: 'home#show'

  resources :home
  resources :lists

  root 'public_pages#home'
end
