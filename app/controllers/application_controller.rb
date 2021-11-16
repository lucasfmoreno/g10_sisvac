class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys:[:nombre,:dni,:edad,:apellido,:direccion,:vacunatorio,:rol,:diabetico,:enfermedadCardio,:enfermadadCardioDesc,:Otros])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:dni,:nroref])
		devise_parameter_sanitizer.permit(:account_update, keys: [:direccion,:email,:vacunatorio])
	end


end
