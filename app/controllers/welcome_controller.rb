class WelcomeController < ApplicationController
  
  def index
    puts "LOS PARAMS EN INDEX SON #{params}"
    if(params[:vengo_filtro_vacuna] == nil)
      @turnosPendientesEnTerminal = Turno.where(:estado => "Pendiente").where(:lugar => "Terminal").limit(20)
      @turnosPendientesEnCementerio = Turno.where(:estado => "Pendiente").where(:lugar => "Cementerio").limit(20)
      @turnosPendientesEnMunicipalidad = Turno.where(:estado => "Pendiente").where(:lugar => "Municipalidad").limit(20)
    else
      filtro_vacuna = params[:filtro][:tipo_vacuna]
      filtro_fecha = params[:filtro][:fecha_asignada]
      puts "LOS PARAMS CON CADA UNO = #{filtro_vacuna} Y #{filtro_fecha}"
      if(filtro_fecha != "" && filtro_vacuna != "TIPO VACUNA")
        @turnosPendientesEnTerminal = Turno.where(:estado => "Pendiente").where(:lugar => "Terminal").where(:tipovacuna => filtro_vacuna).where(:remember_created_at => filtro_fecha).limit(20)
        @turnosPendientesEnCementerio = Turno.where(:estado => "Pendiente").where(:lugar => "Cementerio").where(:tipovacuna => filtro_vacuna).where(:remember_created_at => filtro_fecha).limit(20)
        @turnosPendientesEnMunicipalidad = Turno.where(:estado => "Pendiente").where(:lugar => "Municipalidad").where(:tipovacuna => filtro_vacuna).where(:remember_created_at => filtro_fecha).limit(20)
      elsif (filtro_fecha != "")
        @turnosPendientesEnTerminal = Turno.where(:estado => "Pendiente").where(:lugar => "Terminal").where(:remember_created_at => filtro_fecha).limit(20)
        @turnosPendientesEnCementerio = Turno.where(:estado => "Pendiente").where(:lugar => "Cementerio").where(:remember_created_at => filtro_fecha).limit(20)
        @turnosPendientesEnMunicipalidad = Turno.where(:estado => "Pendiente").where(:lugar => "Municipalidad").where(:remember_created_at => filtro_fecha).limit(20)
      elsif (filtro_vacuna != "TIPO VACUNA")
        @turnosPendientesEnTerminal = Turno.where(:estado => "Pendiente").where(:lugar => "Terminal").where(:tipovacuna => filtro_vacuna).limit(20)
        @turnosPendientesEnCementerio = Turno.where(:estado => "Pendiente").where(:lugar => "Cementerio").where(:tipovacuna => filtro_vacuna).limit(20)
        @turnosPendientesEnMunicipalidad = Turno.where(:estado => "Pendiente").where(:lugar => "Municipalidad").where(:tipovacuna => filtro_vacuna).limit(20)
      else
        #si vine con boton pero sin data imprimo cualquiera
        @turnosPendientesEnTerminal = Turno.where(:estado => "Pendiente").where(:lugar => "Terminal").limit(20)
        @turnosPendientesEnCementerio = Turno.where(:estado => "Pendiente").where(:lugar => "Cementerio").limit(20)
        @turnosPendientesEnMunicipalidad = Turno.where(:estado => "Pendiente").where(:lugar => "Municipalidad").limit(20)
      end
    end
  end
  
end
