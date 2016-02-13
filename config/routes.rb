Rails.application.routes.draw do
  devise_for :users, controllers: {:registrations => "users/registrations"}

  root 'games#index'

  resources :players
  resources :teams
  get 'games/schedule_week', to: 'games#new_week'
  post 'games/schedule_week', to: 'games#create_week'

  resources :games do
    post 'update_score', to: 'games#update_score'
    resources :team_games, only: [:create]
  end


  resources :users, only: [:index, :show, :destroy]
  patch 'users/:id', to: 'users#update'

  resources :game_stats, only: [:update]
  resources :schedules
  resources :invitations

  resources :commissioner, only: [:index]
  get 'commissioner/getplayers', to: 'commissioner#get_players', as: :get_players
  get 'commissioner/loadstats', to: 'commissioner#load_stats', as: :load_stats
  get 'commissioner/export_week', to: 'commissioner#export_week', as: :export_week

  get 'games/:id/scorekeep', to: 'games#scorekeep', as: :scorekeep_games

  get 'createschedule', to: 'games#create_schedule', as: :schedule_games
  get 'deleteall', to: 'games#delete_all', as: :destroy_games

end
