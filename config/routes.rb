Rails.application.routes.draw do
  resources :notes
  resources :books do 
    collection do
      get 'list_all_notes'
    end
    member do
      get 'list_notes'
    end
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
