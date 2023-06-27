# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "auth/v1/user"
  namespace :admin do
    namespace :v1 do
      resources :categories
    end
  end  
end
