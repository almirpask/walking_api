Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    namespace :v1 do
      resources :dog_walkings, only: [:index, :create, :show], :defaults => { :format => 'json' } do
        put :start_walk
        put :finish_walk
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
