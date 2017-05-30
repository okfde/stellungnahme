Rails.application.routes.draw do
  resources :comments
  resources :organizations
  resources :drafts
  resources :documents
  resources :ministries
  resources :laws

  root 'site#index'
end
