class TurnoAsignadoMailer < ApplicationMailer
    default from: 'sisvac.g10@gmail.com'
    
    def info_turno
        @user = params[:user]
        @turno = params[:turno]
        mail(to: @user.email, subject: 'Informacion sobre turno')
    end

end
