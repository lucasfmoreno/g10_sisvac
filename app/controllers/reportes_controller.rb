class ReportesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def show
    @turno=Turno.where(:fechaRecibir=>params[:fechaRecibir])
    @covid=@turno.where(:tipovacuna=>"COVID")
    @fa=@turno.where(:tipovacuna=>"Fiebre Amarilla")
    @gr=@turno.where(:tipovacuna=>"Gripe")
  end
end
