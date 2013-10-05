Taskie::Application.routes.draw do
  devise_for :users

  resources :tasks do
    resources :comments, only: [ :create ]
  end

  get "/tasks" => "tasks#index", as: :user_root

  controller :static do
    root to: :root
  end
end
