Rails.application.routes.draw do
  resource :cart, controller: "cart", only: [:show, :update, :edit] do
    member do
      post :add_product
      post :remove_product
      get  :confirmation
      post :finish
    end
  end

  
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
    root to: 'products#index'
    resources :products
    resources :categories
    resources :orders, only: [:show, :index, :update]
  end
  
  get 'regulamin', to: "static#terms", as: :terms
  get 'polityka-prywatnosci', to: "static#privacy", as: :privacy
  get 'dostawa', to: "static#shipping", as: :shipping
  get 'o-sklepie', to: "static#about", as: :about
  
  root to: "products#index"
  resources :products, only: [:show, :index], path: "produkt"
  resources :categories, only: [:show], path: "kategoria"

end
