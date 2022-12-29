Rails.application.routes.draw do

   devise_for :customers,controllers:{
    registrations:"public/registrations",
    sessions:'public/sessions',
    passwords: "public/passwords"
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }

  namespace :admin do
    #get 'top' => 'homes#top', as: 'top'
    #get 'search' => 'homes#search', as: 'search'
    resources :customers, only: [:index, :show, :edit, :update]
    resources:restaurants,only:[:index,:new,:create,:show,:edit,:update,:destroy]
    resources:reviews,only:[:index,:edit,:update]
    resources :genres, only: [:index, :create, :edit, :update]
    #resources :orders, only: [:index, :show, :update] do
      #resources :order_details, only: [:update]
    #end
  end

  scope module: :public do
    root 'homes#top'
    get 'map_search' => 'homes#map_search', as: 'map_search'


    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    put 'customers/information' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'

    resources :customers, only: [:show] do
      member do
        get :favorites
        get :reviews
      end
    end


    #resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :restaurants, only: [ :show, :index] do
      resource :favorites, only: [:create, :destroy]
      resources :reviews, only: [:create,:destroy,:update]
    end
    #resources :cart_items, only: [:index]
    #resources :orders, only: [:new, :index, :create, :show]

  end





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
