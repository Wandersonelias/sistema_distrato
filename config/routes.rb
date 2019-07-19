Rails.application.routes.draw do
  



  resources :funcionarios
  devise_for :users
  resources :entregas
  resources :reparos
  resources :conta
  resources :tipo_conta
  resources :aluguels
  get '/entregas/teste/:id', to: "entregas#teste"
  #put '/entregas/teste/:id', to: "entregas#teste"



  root to: 'entregas#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
