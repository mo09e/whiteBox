Rails.application.routes.draw do
  resources :galleries do
    resources :reservations
  end
  resources :artists
  resources :homes, only: [:index, :show]
  # resources :users, only: [:show]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  root to: "homes#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end
end
