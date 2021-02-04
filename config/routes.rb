Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users, only: :passwords, controllers: { passwords: 'users/passwords' }

  devise_scope :user do
    get 'users/password_changed', to: 'users/passwords#changed', as: 'changed_user_password'
  end

  namespace :admin do
    resources :admin_users
    resources :users

    root to: "admin_users#index"
  end

  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create] do
        post :reset, on: :collection
      end
      resources :sessions, only: [:create]
      resources :users, only: [:update]
    end
  end

  root to: 'admin/users#index'
end
