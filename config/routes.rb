Rails.application.routes.draw do
  resources :welcome, only: [:index]

  root 'welcome#index'

  get 'games/past', to: 'games#past_index', as: :past_games
  get 'games/upcoming', to: 'games#upcoming_index', as: :upcoming_games
  get 'games/current', to: 'games#current_index', as: :current_games

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
