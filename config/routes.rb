Rails.application.routes.draw do
  get 'pages/index'
  get 'pages/about'
  get 'pages/ups'
  get "/nasa-app", to: "agencies#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'pages/my_create', to: 'pages#my_create', as: 'my_create_pages'
  root "pages#index"
end
