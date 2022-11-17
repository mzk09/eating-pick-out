Rails.application.routes.draw do
  namespace :admin do
    resources:restaurants,only:[:index,:new,:create,:show,:edit,:update,:destroy]
  end
  root 'public/homes#top'

  namespace :public do
  end
  
  devise_for :customers,controllers:{
    registrations:"public/registrations",
    sessions:'public/sessions'
  }

  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
