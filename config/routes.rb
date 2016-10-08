Rails.application.routes.draw do
  root 'searches#new'

  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  resources :users, only: [:show, :edit, :update]
  resources :trains, only: [:show]
  resources :routes, only: [:index, :show]
  resources :tickets, only: [:index, :new, :show, :create, :destroy]
  resources :carriages, only: [:show]
  resources :railway_stations, only: [:show]

  namespace :admin do
    resources :users
    resources :routes do
      put 'update_name' => 'routes#update_name'
    end
    resources :tickets

    resources :trains do
      resources :carriages, shallow: true
      put 'update_name' => 'trains#update_name'
    end

    resources :railway_stations do
      member do
        patch :update_position
        patch :update_arrival_datetime
        patch :update_departure_datetime
      end
    end
  end

  resource :search do
    get '/' => 'searches#new'
    post '/' => 'searches#show_results'
  end
end
