Rails.application.routes.draw do
  get 'vacuna_dadas/new'
  get 'vacuna_dadas/create'
  get 'vacuna_dadas/show'
  get 'turnos/index'
  get 'turnos/new'
  get 'turnos/create'
  get 'turnos/show'
  get 'turnos/turno'
  get 'mis_datos/show'
  get '/search_user', to: 'search#search_user'
  root 'welcome#index'
  resources :vacunas
  resources :turnos do
    get ':elevarEstado' => 'turnos#show', :as => 'cambiarEstado'
  end
  resources :vacuna_dadas do
    get ':turno_id' => 'vacuna_dadas#create', :as => 'atenderVacuna'
  end
  devise_for :users, :controllers =>{registrations: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
