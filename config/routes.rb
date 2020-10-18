Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  resources :galleries do
    resources :reservations
  end
  resources :artists
  resources :homes, only: [:index, :show]
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
