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
      redirect_to root_path, :notice => "Se atendio el turno"
    else
      flash[:error] = "Hubo un error al agregar la vacuna"
      @vacunaNueva=VacunaDada.new(params[:post])
      render "new"
    end
  end

  def show
  end
end
