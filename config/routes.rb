Rails.application.routes.draw do
  resources :documents
  resources :ministries
  resources :laws

  root 'site#index'
end
