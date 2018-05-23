Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'harvest', to: 'items#harvest'
  get 'inventory', to: 'items#inventory'

end
