class SearchController < ApplicationController

    def search_user 
            @get_user = User.where(:dni => params[:dni]).first
            @turno=Turno.where(:estado => "Aceptado").where(:user_id =>@get_user)
            @exists=true
    end
end