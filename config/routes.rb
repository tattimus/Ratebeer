Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  # get 'ratings', to: 'ratings#index'
  resources :beers
  resources :breweries
  get 'signup', to: 'users#new'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'places', to: 'places#index'
  post 'places', to:'places#search'
  resources :places, only: [:index, :show]
end
