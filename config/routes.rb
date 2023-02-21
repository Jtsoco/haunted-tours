Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tours, only: [:index, :new, :create, :show] do
    resources :bookings, only: :create
  end
  get '/hosted_tours', to: 'tours#hosted_tours', as: :hosted_tours
  get '/booked_tours', to: 'bookings#index', as: :booked_tours


  # Defines the root path route ("/")
  # root "articles#index"
end
