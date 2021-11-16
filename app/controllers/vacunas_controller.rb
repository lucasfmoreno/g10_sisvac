class VacunasController < ApplicationController
	def new
	end

	def show
		@vacuna=VacunaDada.where(:user_id => current_user.id)
	end
end
