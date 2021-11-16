class InvitadosController < ApplicationController
  def new
    @user=User.new  
    sign_out current_user 
  end     


  def create
      @user = User.new(:email => "fulano@hotmail.com", :password => "tugoi2021",:password_confirmation=>"tugoi2021")
      @user.save
  end
end
