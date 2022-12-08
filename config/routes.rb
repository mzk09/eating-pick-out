Rails.application.routes.draw do

   devise_for :customers,controllers:{
    registrations:"public/registrations",
    sessions:'public/sessions'
  }

  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }

  namespace :admin do
    #get 'top' => 'homes#top', as: 'top'
    #get 'search' => 'homes#search', as: 'search'
    resources :customers, only: [:index, :show, :edit, :update]
    resources:restaurants,only:[:index,:new,:create,:show,:edit,:update,:destroy]
    resources:reviews,only:[:index,:edit,:update]
    #resources :genres, only: [:index, :create, :edit, :update]
    #resources :orders, only: [:index, :show, :update] do
      #resources :order_details, only: [:update]
    #end
  end

  scope module: :public do
    root 'homes#top'

    #deviseのルーティングと被ってしまう？書き方質問すること
    resources :customers, only: [:show] do
      member do
        get :favorites
        get :reviews
      end
    end

    #get 'customers/mypage' => 'customers#show', as: 'mypage'
    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    put 'customers/information' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    #delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'


    #resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :restaurants, only: [ :show, :index] do
      resource :favorites, only: [:create, :destroy]
      resources :reviews, only: [:create,:destroy]
    end
    #resources :cart_items, only: [:index]
    #resources :orders, only: [:new, :index, :create, :show]

  end





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
