Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  resources :players
  resources :teams
  resources :games do
    resources :team_games, only: [:create]
  end
  resources :game_stats, only: [:update]
  resources :schedules

  get 'createschedule', to: 'games#create_schedule', as: :schedule_games
  get 'deleteall', to: 'games#delete_all', as: :destroy_games
end
