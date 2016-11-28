Rails.application.routes.draw do
  get 'primitives/prim2poppydance'
  get 'primitives/prim2poppyidle'
  get 'primitives/prim2poppyinit'
  get 'primitives/prim2poppyhead'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
