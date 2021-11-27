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
      @usuarioLlego = params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros)
      if ((User.where(:dni => @usuarioLlego.require(:dni)).count==0) && (User.where(:email => @usuarioLlego.require(:email)).count==0))
        edad = Integer(@usuarioLlego.require(:edad))
        if(edad>60)
          flash[:error] = "El paciente no puede tener mas de 60 años."
          @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros))
          render "invitados/new"
        else
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
        end
      else
        flash[:error] = "DNI o email ya utilizados."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros))
        render "invitados/new"
      end

    elsif (params[:vengo_de_new_vacunadores] == "si")
      @usuarioLlego = params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio)
      if ((User.where(:dni => @usuarioLlego.require(:dni)).count==0) && (User.where(:email => @usuarioLlego.require(:email)).count==0))
        dniDelUltimo = User.find(User.maximum(:id)).dni
        super
        usuarioCreado = User.find(User.maximum(:id))
        if(usuarioCreado.dni != dniDelUltimo)
          usuarioCreado.rol = "Vacunador"
          usuarioCreado.confirmed_at = DateTime.now
          usuarioCreado.nroref = 0
          usuarioCreado.save
        else
          flash[:error] = "ERROR REGISTRO DEVISE"
          @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio))
          render "vacunadores/new"
        end
      else
        flash[:error] = "DNI o email ya utilizados."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio))
        render "vacunadores/new"
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
