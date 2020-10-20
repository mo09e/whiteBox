Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end

  resources :galleries do
    resources :reservations
  end
  resources :artists
  resources :homes, only: [:index, :show]
  resources :users, only: [:show]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :artists_favorites, only: [:create, :destroy]
  resources :galleries_favorites, only: [:create, :destroy]
  root to: "homes#index"

  get "users/:id/favorites" => "users#favorites"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
