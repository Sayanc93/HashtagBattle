Rails.application.routes.draw do
  root 'home#index'
  resources :users

  get 'dashboard', to: 'dashboard#index'
  post 'dashboard', to: 'dashboard#create'
  post 'dashboard/battle', to: 'dashboard#initiate_battle'
  get 'dashboard/terminate_battle', to: 'dashboard#terminate_battle'
  get 'dashboard/reset_counters', to: 'dashboard#reset_counters'

  match 'auth/:provider/callback', to: 'sessions#create', via: :get
  delete 'session/destroy', to: 'sessions#destroy'

  mount ActionCable.server => '/cable'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
