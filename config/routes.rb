Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tours, only: [:index, :new, :create, :show] do
    post 'booking', to: 'bookings#create'
  end
  get '/hosted_tours', to: 'tours#hosted_tours', as: :hosted_tours
  get '/bookings', to: 'bookings#index', as: :booked_tours
  get '/bookings/new', to: 'bookings#new', as: :bookings_new


  # Defines the root path route ("/")
  # root "articles#index"
end
