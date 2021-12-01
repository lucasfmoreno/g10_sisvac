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
      puts "EL DNI ES = #{params[:user].permit(:dni)} Y EL MAIL ES #{params[:user].permit(:email)}"
      if(params[:user][:dni]=="")
        flash[:error] = "DNI VACIO."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros))
        render "invitados/new"
      elsif(params[:user][:email]=="")
        flash[:error] = "MAIL VACIO."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros))
        render "invitados/new"
      else
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
      @usuarioLlego = params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros,
        :se_puso_covid,:se_puso_gripe,:dosis_covid,:fecha_gripe)
      if(@usuarioLlego.require(:se_puso_covid)=="1"&&@usuarioLlego.require(:dosis_covid)=="0")
        flash[:error] = "Se puso COVID pero no indica dosis."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio))
        render "devise/registrations/new"
      elsif (@usuarioLlego.require(:se_puso_gripe)=="1"&&@usuarioLlego.require(:fecha_gripe)==Date.today)
        flash[:error] = "Se puso GRIPE pero no indica fecha."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio))
        render "devise/registrations/new"
      elsif (@usuarioLlego.require(:se_puso_gripe)=="1"&&@usuarioLlego.require(:fecha_gripe).to_date>Date.today)
        flash[:error] = "Se puso GRIPE fecha es posterior a hoy."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio))
        render "devise/registrations/new"
      elsif(@usuarioLlego.require(:se_puso_covid)=="1"&&@usuarioLlego.require(:dosis_covid)>"3")
        flash[:error] = "Se puso COVID pero dosis > 3."
        @user=User.new(params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio))
        render "devise/registrations/new"
      else
        if(User.all.count > 0)
          @dniDelUltimo = User.find(User.maximum(:id)).dni
        else
          @dniDelUltimo = 999999999
        end
        super
        @usuarioCreado = User.find(User.maximum(:id))
        if(@usuarioCreado.dni != @dniDelUltimo && @usuarioCreado.email == @usuarioLlego.require(:email))
          if(@usuarioCreado.se_puso_gripe == true)
            turno = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "GRIPE", :remember_created_at=>@usuarioCreado.fecha_gripe, :estado=>"Vacunado", :fechaRecibir => @usuarioCreado.fecha_gripe,
              :lugar => "VACUNADO ANTES DE REGISTRARSE", :observacion => "")
            turno.save
            vacunaDada = VacunaDada.new(:user_id => @usuarioCreado.id, :turno_id => turno.id, :tipo_vacuna=>turno.tipovacuna, :fecha_solicitud=>turno.remember_created_at,
              :fecha_dada=>turno.remember_created_at, :observacion => "")
            vacunaDada.save

            #Me fijo si paso mas de un año de la vacunacion
            fechaVacunacion = Date.parse(@usuarioCreado.fecha_gripe)
            fechaHaceUnAño = Date.today - 1.year
            pasoMasDeUnAño = fechaVacunacion<fechaHaceUnAño
            if(pasoMasDeUnAño==true)
              turnoNuevo = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "GRIPE", :estado => "Pendiente", :lugar => @usuarioCreado.vacunatorio)
              turnoNuevo.save
            end
          else
            turnoNuevo = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "GRIPE", :estado => "Pendiente", :lugar => @usuarioCreado.vacunatorio)
            turnoNuevo.save
            @usuarioCreado.fecha_gripe = ""
            @usuarioCreado.save
          end
              
          if(@usuarioCreado.se_puso_covid == true)
            cantidadDosis = @usuarioCreado.dosis_covid
            for dosis in 1..cantidadDosis
              turno = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "COVID", :remember_created_at=>@usuarioCreado.fecha_gripe, :estado=>"Vacunado", :fechaRecibir => @usuarioCreado.fecha_gripe,
                :lugar => "VACUNADO ANTES DE REGISTRARSE", :observacion => "")
              turno.save
              vacunaDada = VacunaDada.new(:user_id => @usuarioCreado.id, :turno_id => turno.id, :tipo_vacuna=>turno.tipovacuna, :fecha_solicitud=>turno.remember_created_at,
                :fecha_dada=>turno.remember_created_at, :observacion => "", :dosis => dosis)
              vacunaDada.save        
            end
            if(cantidadDosis<3)
              turnoNuevo = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "COVID", :estado => "Pendiente", :lugar => @usuarioCreado.vacunatorio)
              turnoNuevo.save
            end          
          else
            turnoNuevo = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "COVID", :estado => "Pendiente", :lugar => @usuarioCreado.vacunatorio)
            turnoNuevo.save
            @usuarioCreado.dosis_covid = nil
            @usuarioCreado.save
          end
        end
      end
      
    end    
  end
  private

  def sign_up_params
    params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:enfermedadCardio,:diabetico,
      :se_puso_covid,:se_puso_gripe,:dosis_covid,:fecha_gripe)
  end
  def configure_account_update_params
     params.require(:user, :email, :direccion).permit(:direccion, :email, :vacunatorio)
  end
end
