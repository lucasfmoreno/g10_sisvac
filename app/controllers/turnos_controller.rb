class TurnosController < ApplicationController
  def index
  end

  def new
    @turno=Turno.new
  end

  def create
    @usuario = current_user
    @turno=Turno.new(params[:turno].permit(:tipovacuna,:observacion))
    @turno.user_id = @usuario.id
    if @turno.save
        redirect_to root_path, :notice => "Enviado!"
    else
        flash[:error] = "Hubo un error"
        render "new"
    end
  end

  def show
    @turno = Turno.find(params[:id])
  end
end
