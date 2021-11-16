class VacunaDadasController < ApplicationController

  def new
    @vacunaNueva = VacunaDada.new
  end

  def create
    @turno = Turno.find(params[:turno_id])
    @userId = params[:user_id]
    @vacNueva = VacunaDada.new(params[:vacuna_dada].permit(:tipo_vacuna,:dosis,:observacion))
    @vacNueva.user_id = @userId
    @vacNueva.save
    @turno.elevarEstado
    redirect_to root_path, :notice => "Se atendio el turno"
  end

  def show
  end
end
