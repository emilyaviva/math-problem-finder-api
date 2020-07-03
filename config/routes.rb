Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :categories, only: [:index]
      resources :lessons, only: [:index]
      resources :tasks, only: [:index]
    end
  end
end
