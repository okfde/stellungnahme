Rails.application.routes.draw do
  resources :ministries
  resources :laws

  root 'site#index'
end
