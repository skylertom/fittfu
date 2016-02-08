Rails.application.routes.draw do
  devise_for :users, controllers: {:registrations => "users/registrations"}

  root 'games#index'

  resources :players
  resources :teams
  resources :games do
    resources :team_games, only: [:create]
  end
  resources :users, only: [:index, :show, :destroy]
  patch 'users/:id', to: 'users#update'

  resources :game_stats, only: [:update]
  resources :schedules
  resources :invitations

  resources :commissioner, only: [:index]
  get 'commissioner/getplayers', to: 'commissioner#get_players', as: :get_players_commissioner

  get 'games/:id/scorekeep', to: 'games#scorekeep', as: :scorekeep_games

  get 'createschedule', to: 'games#create_schedule', as: :schedule_games
  get 'deleteall', to: 'games#delete_all', as: :destroy_games
end
