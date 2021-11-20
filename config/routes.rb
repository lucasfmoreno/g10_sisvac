Rails.application.routes.draw do
  get 'cambios/edit'
  get 'cambios/update'
  get 'vacunadores/new'
  get 'vacunadores/create'
  get 'invitados/new'
  get 'invitados/show'
  get 'vacuna_dadas/new'
  get 'vacuna_dadas/create'
  get 'vacuna_dadas/show'
  get 'turnos/index'
  get 'turnos/new'
  get 'turnos/create'
  get 'turnos/show'
  get 'turnos/turno'
  get 'mis_datos/show'
  get 'invitados/new'
  get 'invitados/show'
  get 'vacunadores/new'
  get 'vacunadores/create'
  get 'cambios/edit'
  post 'cambios/update'
  get '/search_user', to: 'search#search_user'
  post "reducirTodos"=>"turnos#reducirTodos", as: :reducirTodos
  root 'welcome#index'
  resources :vacunas
  resources :turnos do
    get ':elevarEstado' => 'turnos#show', :as => 'cambiarEstado'
  end
  resources :vacuna_dadas do
    get ':turno_id' => 'vacuna_dadas#create', :as => 'atenderVacuna'
  end
  devise_for :users, :controllers =>{registrations: 'users/registrations'}
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
