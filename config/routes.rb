Rails.application.routes.draw do
  root 'movies#index'

  resources :reviews, except: [:new, :edit]
  resources :movies, except: [:new, :edit]
end
