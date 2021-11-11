class SearchController < ApplicationController

    def search_user 
            @get_user = User.where(:dni => params[:dni]).first
            @exists=true
    end
end
