class VacunaDadasController < ApplicationController

  def new
    @vacunaNueva = VacunaDada.new
  end

  def create
    @turno = Turno.find(params[:turno_id])
    @userId = params[:user_id]
    @vacNueva = VacunaDada.new(params[:vacuna_dada].permit(:tipo_vacuna,:dosis,:observacion))
    @vacNueva.user_id = @userId
    @vacNueva.turno_id=@turno.id
    @vacNueva.fecha_solicitud = @turno.remember_created_at
    if @vacNueva.save
      @turno.elevarEstado
      if(@turno.tipovacuna=="COVID"&&@vacNueva.dosis<3)
        usuarioVacunado = User.find(@userId)
        turnoNuevo = Turno.new(:user_id => usuarioVacunado.id, :tipovacuna => "COVID", :estado => "Pendiente", :lugar => usuarioVacunado.vacunatorio)
        turnoNuevo.save
        redirect_to root_path, :notice => "Se atendio el turno y se solicito turno para la proxima dosis(#{@vacNueva.dosis+1})."  
      else
        redirect_to root_path, :notice => "Se atendio el turno"
      end
    else
      flash[:error] = "Hubo un error al agregar la vacuna"
      @vacunaNueva=VacunaDada.new(params[:post])
      render "new"
    end
  end

  def show
  end
end
