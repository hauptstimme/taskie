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
      controller "devise/registrations" do
        get 'users/edit', action: :edit, as: 'edit_user_registration'
        patch 'users', action: :update, as: 'user_registration'
      end
    end

  resources :projects, except: :index do
    resources :milestones
    resources :tasks, concerns: :commentable do
      get :follow, on: :member
    end
  end

  resource :settings, only: [:show, :update]

  controller :pages do
    root action: :dashboard
  end
end
