class SearchController < ApplicationController

    def search_user
        puts "CURRENT ES #{current_user.rol}"
        if(current_user.rol=="Administrador")
            @get_user = User.where(:dni => params[:dni]).where(:rol => "Vacunador").first
        elsif (current_user.rol=="Vacunador")
            @get_user = User.where(:dni => params[:dni]).where(:rol => "Paciente").first
        end
        @turno=Turno.where(:estado => "Aceptado").where(:user_id =>@get_user).where(:fechaRecibir=>Date.today)
        @exists=true
    end
end
