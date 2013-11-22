Taskie::Application.routes.draw do
  concern :commentable do
    resources :comments, only: [:show, :create, :edit, :update, :destroy]
  end

  namespace :api, defaults: { format: :json } do
    resources :projects, only: [:index, :show] do
      resources :tasks, only: [:index, :show]
    end
  end

  devise_for :users

  resources :projects do
    resources :tasks, concerns: :commentable
  end

  resource :settings, only: [:show, :update]

  get "/projects" => "projects#index", as: :user_root
  root to: redirect("/projects")
end
