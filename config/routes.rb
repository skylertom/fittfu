Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  resources :players
  resources :teams
  resources :games
end
