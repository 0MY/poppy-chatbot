Rails.application.routes.draw do
  get 'primitives/prim2poppy'
  get 'primitives/list2poppy'
  get 'motors/motor2poppy'
  get 'motors/list2poppy'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
