Taskie::Application.routes.draw do
  devise_for :users

  controller :static do
    root to: :root
  end
end
