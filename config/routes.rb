Rails.application.routes.draw do
  resources :homes, only: [:index]
  root to: "homes#index"
end
