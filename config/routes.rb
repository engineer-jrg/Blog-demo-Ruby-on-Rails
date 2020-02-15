Rails.application.routes.draw do
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "home#index"

  get '/', to: 'home#index'

  resources :articles do
    resources :comments, only: [:create, :update, :destroy, :show]
  end
  
  devise_for :users

  get "/dashboard", to: "home#dashboard"
  put "/articles/:id/publish", to: "articles#publish"
  put "/articles/:id/unpublish", to: "articles#unpublish"
end
