Rails.application.routes.draw do
  
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  devise_for :users
  root to: 'pages#home'
  get '/dashboard' => "users#index"
  resources :trackers, except: [:index] do
    resources :added_games, only: %i[new create destroy]
  end
end
