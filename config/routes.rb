Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users

  namespace :admin do
    resources :admin_users
    resources :users

    root to: "admin_users#index"
  end

  root to: 'admin/users#index'
end
