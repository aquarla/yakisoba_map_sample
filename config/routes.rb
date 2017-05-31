Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'map/index'
  get 'area/:code', :to => 'map#index', :as => "map_area"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, :only => [:show]

  root to: 'map#index'
end
