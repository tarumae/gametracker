Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard' => "users#index"
  resources :trackers, except: [:index]
end
