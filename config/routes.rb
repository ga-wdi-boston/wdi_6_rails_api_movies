Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, except: [:new, :edit, :destroy]

  namespace :admin do
    resources :movies
  end

  match "/404", :to => "errors#not_found", via: [:get]
end
