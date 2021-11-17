# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #before_action :configure_sign_up_params, only: [:create]

   #before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if(params[:vengo_de_new]=="si")
      puts "ENTRE POR EL NEW"
      @usuarioLlego = params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros)

      @dniDelUltimo = User.find(User.maximum(:id)).dni
      super
      @usuarioCreado = User.find(User.maximum(:id))

      @campoVacunadoSin = params[:vacunar_sin_turno]
      @campoObsVac = params[:observacion_vacunacion]

      #Antes de crear recupere el dni del Paciente con id maximo (el mas nuevo, a pesar de que se borren).
      #Comparo ese dni con el de el ultimo agregado posterior al "super" que agrega en devise
      #Si el dni es distinto es porque el Paciente con id maximo cambio, por lo tanto se agrego.
      puts "EL DNI DEL CREADO ES #{@usuarioCreado.dni} == #{@dniDelUltimo}"
      if(@usuarioCreado.dni != @dniDelUltimo)
        puts "EL CAMPO ES #{@campoVacunadoSin}, LA OBS ES #{@campoObsVac} y el DNI es #{@usuarioCreado.dni} == #{@usuarioLlego.require(:dni)}"
        if(@usuarioCreado.email == @usuarioLlego.require(:email) && @campoVacunadoSin == "VACUNADOSINTURNO")
         @turnoNuevo = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "FIEBRE AMARILLA", :remember_created_at=>Date.today, :estado=>"Vacunado", :fechaRecibir =>Date.today,
          :lugar => @user.vacunatorio, :observacion => @campoObsVac)
        @turnoNuevo.save
        @vacunaNueva = VacunaDada.new(:user_id => @usuarioCreado.id, :turno_id => @turnoNuevo.id, :tipo_vacuna=>@turnoNuevo.tipovacuna, :fecha_solicitud=>@turnoNuevo.remember_created_at,
          :fecha_dada=>@turnoNuevo.remember_created_at, :observacion => @campoObsVac)
        @vacunaNueva.save
        end
      end
    else
      super
    end    
  end
  private

  def sign_up_params
    params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:enfermedadCardio)
  end
  def configure_account_update_params
     params.require(:user, :email, :direccion).permit(:direccion, :email, :vacunatorio)
  end
end
