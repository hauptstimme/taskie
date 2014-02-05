Taskie::Application.routes.draw do
  concern :commentable do
    resources :comments, only: [:show, :create, :edit, :update, :destroy]
  end

  namespace :api, defaults: { format: :json } do
    resources :users, only: :show
    resources :projects, only: [:index, :show] do
      resources :milestones, only: [:index, :show]
      resources :tasks, only: [:index, :show]
    end
  end

  devise_for :users, skip: [:registrations]
    as :user do
      get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
      patch 'users', to: 'devise/registrations#update', as: 'user_registration'
    end

  resources :projects, except: :index do
    resources :milestones
    resources :tasks, concerns: :commentable do
      get :follow, on: :member
    end
  end

  resource :settings, only: [:show, :update]

  controller :pages do
    root to: :dashboard
  end
end
