class ReportesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def show
    @turno=Turno.where(:fechaRecibir=>params[:fechaRecibir])
    @turnoH=Turno.where(:remember_created_at=>params[:fechaRecibir])
    @covid=@turno.where(:tipovacuna=>"COVID")
    @fa=@turno.where(:tipovacuna=>"FIEBRE AMARILLA")
    @gr=@turno.where(:tipovacuna=>"GRIPE")
  end
end
