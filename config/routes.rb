Rails.application.routes.draw do
  get 'turnos/index'
  get 'turnos/new'
  get 'turnos/create'
  get 'turnos/show'
  root 'welcome#index'
  get 'turnos/turno'
  resources :vacunas
  resources :turnos
  devise_for :users, :controllers =>{registrations: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
