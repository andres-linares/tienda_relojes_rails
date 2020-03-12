Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  get 'about' => 'pages#about'

  resources :products do
    resources :purchases, only: [:index, :new, :create]
  end

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :products, only: [:index]
    end
  end
end
