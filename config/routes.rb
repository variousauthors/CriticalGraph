Ooshew::Application.routes.draw do

  resources :articles
  root to: 'articles#index'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

end
