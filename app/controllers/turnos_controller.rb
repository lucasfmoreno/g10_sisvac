class TurnosController < ApplicationController
  def index
    @turnosPendientesEnTerminal = Turno.where(:estado => "Pendiente").where(:lugar => "Terminal").limit(20)
      @turnosPendientesEnCementerio = Turno.where(:estado => "Pendiente").where(:lugar => "Cementerio").limit(20)
      @turnosPendientesEnMunicipalidad = Turno.where(:estado => "Pendiente").where(:lugar => "Municipalidad").limit(20)
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

  def update
    turnoAAsignar = Turno.find(params[:id])
    if(params[:commit]=="Asignar Turno")
      turnoAAsignar.fechaRecibir = params[:fecha_asignada]
      turnoAAsignar.estado = "Aceptado"
      turnoAAsignar.save
    elsif (params[:commit]=="Rechazar Turno")
      turnoAAsignar.estado = "Rechazado"
      turnoAAsignar.save
    end
    usuario = User.find(turnoAAsignar.user_id)
    TurnoAsignadoMailer.with(user: usuario, turno: turnoAAsignar).info_turno.deliver_now
    redirect_to root_path, :notice => "Se proceso el turno"
  end

  def reducirTodos
    @turnos = Turno.where(:lugar => current_user.vacunatorio).where(:estado => "Aceptado").where(:fechaRecibir => Date.today)
    @turnos.each do |turno|
      turno.reducirEstado
    end
    redirect_to root_path
  end
  helper_method :reducirTodos

  def show
    @usuario = current_user
    

    @turno = Turno.find(params[:id])

    @usuarioDelTurno = User.find(@turno.user_id)
    @turnosRestantesVacunatorioDelUsuario = Turno.where(:lugar => @usuarioDelTurno.vacunatorio).where(:estado => "Aceptado").count
    @vacunadoresEnVacunatorioDelUsuario = User.where(:vacunatorio => @usuarioDelTurno.vacunatorio).where(:rol => "Vacunador").count
    

    respond_to do |format|
      format.html
      format.pdf do
        pdf = TurnoPdf.new(@turno)
        send_data pdf.render, filename: "order:#{@turno.id}.pdf", type: "application/pdf", disposition: "inline"
      end
    end

  end
end
