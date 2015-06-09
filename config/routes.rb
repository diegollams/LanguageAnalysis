Rails.application.routes.draw do
  get 'cover/show'

  resources :words
  resources :posts
  root 'cover#show'


end
