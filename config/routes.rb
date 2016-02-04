Rails.application.routes.draw do
  devise_for :users, controllers: {:registrations => "users/registrations"}

  root 'games#index'

  resources :players
  resources :teams
  resources :games do
    resources :team_games, only: [:create]
  end

  resources :game_stats, only: [:update]
  resources :schedules
  resources :invitations

  get 'games/:id/scorekeep', to: 'games#scorekeep', as: :scorekeep_games

  get 'createschedule', to: 'games#create_schedule', as: :schedule_games
  get 'deleteall', to: 'games#delete_all', as: :destroy_games
end
