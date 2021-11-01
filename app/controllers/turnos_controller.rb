class TurnosController < ApplicationController
  def index
  end

  def new
    @turno=Turno.new
  end

  def create
    @turno=Turno.new(params[:turno].permit(:usuario_id,:tipovacuna,:observacion))
    if @turno.save
        redirect_to turnos_path, :notice => "Enviado!"
    else
        flash[:error] = "Hubo un error"
        render "new"
    end
  end

  def show
  end
end
