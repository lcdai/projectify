Rails.application.routes.draw do
  root "pages#index"

  namespace :api do
    namespace :v1 do
      post "/register", to: "auth#register"
      post "/login", to: "auth#login"

      resource :dashboard, only: [:show]

      resources :projects do
        resources :tasks
      end

      resources :activities, only: [:index]
    end
  end

  get "*path", to: "pages#home", constraints: ->(req) {
    !req.xhr? && req.format.html?
  }
end
