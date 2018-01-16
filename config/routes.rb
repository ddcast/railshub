Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home' => 'home#show', as: :home

  namespace :api do
    namespace :v1 do
      resources :railshub, only: [:show, :index] do
        collection do
          get :issues
          get :components
        end
      end
    end
  end
end
