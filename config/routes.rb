Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users

  namespace :admin do
    resources :admin_users
    resources :users

    root to: "admin_users#index"
  end

  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :sessions, only: [:create]
    end
  end

  root to: 'admin/users#index'
end
