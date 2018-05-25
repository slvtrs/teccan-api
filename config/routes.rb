Rails.application.routes.draw do
  # root to: ''

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, 
  defaults: { format: :json }
  devise_scope :user do
    patch 'users/update_device', :to => 'users/sessions#update_device'
    delete 'users/log_out', :to => 'users/sessions#log_out'
  end

  get 'harvest', to: 'items#harvest'
  get 'inventory', to: 'items#inventory'

end
