Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :new, :create, :show]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    get "search", on: :collection
    post "delivered", on: :member
    post "canceled", on: :member
    resources :order_items, only: [:new, :create]
  end
end
