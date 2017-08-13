Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'authors', to: 'authors#index'
  get 'books', to: 'books#index'
end
