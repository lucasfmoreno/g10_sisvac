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
    @usuarioLlego = params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros)
    puts "ESTOY EN CREATE DEVISE CON #{@usuarioLlego}"
    @idNuevo = User.maximum(:id).next
    super
    @usuarioCreado = User.find(@idNuevo)
    puts "VOY A REVISAR #{@usuarioCreado} y #{@usuarioLlego}"
    if(@usuarioCreado != nil)
      puts "EN EL CREADO EL OTROS ES #{@usuarioCreado.Otros} y el DNI es #{@usuarioCreado.dni} == #{@usuarioLlego.require(:dni)}"
      if(@usuarioCreado.email == @usuarioLlego.require(:email) && @usuarioCreado.Otros == "VACUNADOSINTURNO")
       @turnoNuevo = Turno.new(:user_id => @usuarioCreado.id, :tipovacuna => "FIEBRE AMARILLA", :remember_created_at=>Date.today, :estado=>"Vacunado", :fechaRecibir =>Date.today,
         :lugar => @user.vacunatorio)
       @turnoNuevo.save
       @vacunaNueva = VacunaDada.new(:user_id => @usuarioCreado.id, :turno_id => @turnoNuevo.id, :tipo_vacuna=>@turnoNuevo.tipovacuna, :fecha_solicitud=>@turnoNuevo.remember_created_at,
          :fecha_dada=>@turnoNuevo.remember_created_at)
       @vacunaNueva.save
      end
    end
  end
  private

  def sign_up_params
    params.require(:user).permit(:nombre,:email,:password,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros)
  end
  def configure_account_update_params
     params.require(:user, :email, :direccion).permit(:direccion, :email, :vacunatorio)
  end
end
