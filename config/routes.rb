Rails.application.routes.draw do
  get 'home/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'

  get 'users/search', as: 'search'
  get 'books/search', as: 'search_book'

  resources :users, only: [:index, :edit, :update, :show]

  resources :books, only: [:show, :create, :index, :edit, :destroy, :update]

  resources :users do
  	member do
  		get :following, :followers
  	end
  end

  resources :relationships, only: [:create, :destroy]
end
