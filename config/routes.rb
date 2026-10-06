Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/register", to: "auth#register"
      post "auth/login", to: "auth#login"
      get "auth/me", to: "auth#me"

      resources :projects do
        resources :tasks
      end

      resources :activities, only: [:index]
    end
  end

  root "pages#home"

  get "*path", to: "pages#home", constraints: ->(req) {
    !req.xhr? && req.format.html?
  }
end
