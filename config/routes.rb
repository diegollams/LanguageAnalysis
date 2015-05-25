Rails.application.routes.draw do
  resources :words
  resources :posts
  root 'posts#index'


end
