Rails.application.routes.draw do
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  # get 'ratings', to: 'ratings#index'
  resources :beers
  resources :breweries
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ratings, only: [:index, :new, :create, :destroy]
end
