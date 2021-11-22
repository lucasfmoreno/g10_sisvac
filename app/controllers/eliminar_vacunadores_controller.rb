class EliminarVacunadoresController < ApplicationController
  def delete
      @user = User.find(params[:id])
      if @user.destroy
        redirect_to root_path, notice: 'Usuario eliminado exitosamente!'
      end
  end
end
