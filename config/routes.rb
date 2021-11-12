Rails.application.routes.draw do
  get 'turnos/index'
  get 'turnos/new'
  get 'turnos/create'
  get 'turnos/show'

  

  get 'turnos/turno'
  get '/search_user', to: 'search#search_user'
  root 'welcome#index'
  resources :vacunas
  resources :turnos do
    get ':elevarEstado' => 'turnos#show', :as => 'cambiarEstado'
  end
  devise_for :users, :controllers =>{registrations: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
