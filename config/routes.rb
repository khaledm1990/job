Rails.application.routes.draw do
  root "users#index"
  resources :users do
    resources :phones, only: [:new, :create, :show]
  end
  resources :phones, only: [:destroy,:edit, :update]

  get "/download", to: "users#download", as: "download"
  post "/upload", to: "users#upload", as: "upload"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
