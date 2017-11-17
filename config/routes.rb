Rails.application.routes.draw do


  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root 'home#index', as: 'home_index', via: :all

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
