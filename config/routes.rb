Dogs::Application.routes.draw do

  resources :dogs

  # can pass in defaults if you want a specific data_type returned
  # defaults: { format: :json }
  namespace :api, path: '/' do
    resources :cats
  end

  root 'static_pages#home'
  match '/contact', to: "static_pages#contact", via: 'get'


end