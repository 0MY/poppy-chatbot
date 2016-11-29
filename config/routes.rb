Rails.application.routes.draw do
  get 'primitives/prim2poppy'
  get 'primitives/motor2poppy'
  get 'primitives/prim_index'


  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
