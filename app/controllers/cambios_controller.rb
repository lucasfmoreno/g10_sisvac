class CambiosController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:edit, :update]
  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if (@user.update(:vacunatorio=>params[:vacunatorio]))
      redirect_to root_path, :notice => "Cambiado!"
    end
  end
end
