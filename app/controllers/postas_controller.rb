class PostasController < ApplicationController
  skip_before_action :verify_authenticity_token
  def edit
    @posta=Posta.where.not(:zona => "VACUNADO ANTES DE REGISTRARSE")
  end

  def update
    @posta=Posta.where(:zona=>params[:zona])
    if @posta.update(:nombre=>params[:nombre],:direccion=>params[:direccion]) && (params[:nombre]!="" && params[:direccion]!="")
      redirect_to root_path, :notice=>"Cambiado!"
    else
      flash[:error] = "No pueden haber campos vacios"
      @posta=Posta.all
      render :edit
    end
  end

end
