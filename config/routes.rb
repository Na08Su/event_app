Rails.application.routes.draw do
  devise_for :users #最上部に記述
  root 'events#index'
  delete '/events/:id/reservations/delete' => 'reservations#destroy', as: 'reservation'
  resources :users, only: [:show]
  resources :events, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      resources :reservations, only: [:create]
    end
  end
  resources :comments, only: [:create]

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
end
