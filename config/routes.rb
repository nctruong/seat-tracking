require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    namespace :v1 do
      namespace :mockup do
        namespace :seat_trackings do
          get 'boardingpass/index'
          post 'pax/list'
          post 'trips/all'
        end
      end
    end
  end

  post 'passenger/reload_list'
  post 'passenger/assign_seat'
  get 'passenger/get_terminal_pax_list'
  get 'passenger/update_passenger_list'
  get 'passenger/history'
  get 'passenger/search'

  namespace :api do
    namespace :v1 do
      get 'trip/index'
      post 'trip/confirm'
      post 'trip/clean_with_reload'
      post 'trip/end_trip'
      post 'passenger/info', to: 'passenger#show'
    end
  end

  root to: 'home#index'
end
