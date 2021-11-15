class WelcomeController < ApplicationController
  def index
    u = User.new(:id => 3, :edad =>4, :dni => 2999, :vacunatorio => "Terminal", :email => "unasdna@gmasdp.com", :direccion => "unadir", :nroref => 2143)
    u.save
  end
end
