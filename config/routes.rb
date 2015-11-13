Ooshew::Application.routes.draw do

  namespace :graph do
  get 'gephi_csv/create'
  end

  resources :articles
  root to: 'articles#index'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

end
