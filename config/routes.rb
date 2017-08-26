Rails.application.routes.draw do
  devise_for :players, controllers: { registrations: 'players/registrations' }

  resources :clubs
  resources :categories
  resources :levels
  resources :divisions
  resources :groups
  resources :teams
  resources :players

  resources :calendars
  resources :leagues
  resources :days
  resources :games

  resources :rankings

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#show'
end
