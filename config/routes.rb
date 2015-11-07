Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  resources :players
  resources :teams
  resources :games
  resources :game_stats, only: [:update]

  get 'createschedule', to: 'games#create_schedule', as: :schedule_games
end
