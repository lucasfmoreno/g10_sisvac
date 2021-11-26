class VacunadoresController < ApplicationController
  def new
    @user=User.new  
    sign_out current_user 
  end     


  def create
      @user = User.new(:email => "fulano@hotmail.com", :password => "tugoi2021",:password_confirmation=>"tugoi2021")
      @user.save
  end

  def show
    @usermuni = User.where(:rol=>"Vacunador").where(:vacunatorio=>"Municipalidad")
    @usercem = User.where(:rol=>"Vacunador").where(:vacunatorio=>"Cementerio")
    @usertermi = User.where(:rol=>"Vacunador").where(:vacunatorio=>"Terminal")
  end
end