Taskie::Application.routes.draw do
  concern :commentable do
    resources :comments, only: [ :show, :create, :edit, :update, :destroy ]
  end

  devise_for :users
  resources :projects do
    resources :tasks, concerns: :commentable
  end

  get "/projects" => "projects#index", as: :user_root
  get "/tasks" => redirect("/projects") # legacy
  root to: "static#root"
end
