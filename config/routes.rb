Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, except: [:new, :edit, :destroy]
  # add a query for movies
  # /movies/q/title/Jaws/description/shark
  # route globbing p48 of Rails4Way
  get '/movies/q/*specs', to: "movies#query"

  namespace :admin do
    resources :movies
  end

  match "/404", :to => "errors#not_found", via: [:get]
end
