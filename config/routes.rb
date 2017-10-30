Rails.application.routes.draw do
  devise_for :players, controllers: { registrations: 'players/registrations' }

  resources :players
  resources :games
  resources :positions

  resources :clubs
  resources :teams

  resources :categories
  resources :levels
  resources :divisions
  resources :groups

  resources :calendars
  resources :leagues
  resources :days

  resources :rankings

  get 'selects/club'
  get 'selects/team'
  resources :selects, only: :create

  get 'enter_games/create'

  resources :admin, only: :index

  root 'homepage#show'
end
