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
    resultadoBoolean = true;
    @turnos =  @usuario.turnos
    tipoVacunaQueLlega = params[:turno][:tipovacuna]
    @turnos.each do |turno|
      if turno.tipovacuna == tipoVacunaQueLlega
        resultadoBoolean = false;
      end
    end
    if(resultadoBoolean == true)
      if @turno.save 
        redirect_to root_path, :notice => "Enviado!"
      else
        flash[:error] = "Hubo un error"
        render "new"
      end
    else
      redirect_to root_path, :notice => "El turno no se agrego, usted ya tiene un turno para esa vacuna."
    end
  end

  def show
    @turno = Turno.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TurnoPdf.new(@turno)
        send_data pdf.render, filename: "order:#{@turno.id}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
end
