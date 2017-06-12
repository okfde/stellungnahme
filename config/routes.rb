Rails.application.routes.draw do
  resources :organizations, except: :index, path: 'verbaende'
  get '/verbaende', to: redirect('/'), as: :organizations_index

  # resources :documents, path: 'd'
  resources :ministries, path: 'ministerien'

  resources :laws, path: 'gesetze' do
    resources :drafts, except: :index
    resources :comments, path: 's', except: :index
  end

  get '/:letter', to: 'site#index', constraints: { letter: /[[:alpha:]]{1,2}/ }

  root 'site#index'
end
