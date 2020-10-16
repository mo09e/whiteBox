Rails.application.routes.draw do
  devise_for :users
  resources :homes, only: [:index]
  root to: "homes#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
