Rails.application.routes.draw do
  resources :books do 
    collection do
      get 'download_all'
    end
    member do
      get 'download'
    end
    resources :notes, except: :index  do 
      member do
        get 'download'
      end
    end
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
