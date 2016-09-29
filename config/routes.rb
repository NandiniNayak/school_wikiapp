Rails.application.routes.draw do
  root 'landing#page'

  resources :posts
  resources :subjects
  get 'admin/home'

  devise_for :admins
  get 'home/page'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
