Rails.application.routes.draw do
  resources :organizations
  resources :documents
  resources :ministries

  resources :laws do
    resources :drafts
    resources :comments
  end

  root 'site#index'
end
