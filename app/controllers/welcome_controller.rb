class WelcomeController < ApplicationController
  
  def index
    @turnosPendientes = Turno.where(:estado => "Pendiente").limit(20)
  end
  
end
