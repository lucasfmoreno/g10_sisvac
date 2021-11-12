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
    @turno.lugar = current_user.vacunatorio
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
    @usuario = current_user

    @turno = nil;
    if(params[:elevarEstado] != nil)
      @turno = Turno.find(params[:turno_id])
    else
      @turno = Turno.find(params[:id])
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = TurnoPdf.new(@turno)
        send_data pdf.render, filename: "order:#{@turno.id}.pdf", type: "application/pdf", disposition: "inline"
      end
    end

    puts "Estado = #{@turno.estado}"
    puts "Elevar = #{params[:elevarEstado]}"

    if (params[:elevarEstado] == "si")
      @turno.elevarEstado
      #redirect_to turno_path(:id => @turno.id), notice: "Se actualizo estado"
      redirect_back(fallback_location: root_path)
    elsif (params[:elevarEstado] == "no")
      @turno.reducirEstado
      #redirect_to turno_path(:id => @turno.id), notice: "Se actualizo estado"
      redirect_back(fallback_location: root_path)
    end
  end
end
