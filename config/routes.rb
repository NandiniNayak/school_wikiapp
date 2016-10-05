Rails.application.routes.draw do
  root 'landing#page'
  resources :subjects
  get 'admin/home'

  devise_for :admins
  get 'home/page'

  devise_for :users
  resources :posts do
    resources :comments, only: [:create]
    member do
      put "like",to:'posts#vote'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
