class Turno < ApplicationRecord
	belongs_to :user, optional: true
	has_one :vacuna_dada
	validates :tipovacuna, presence: true
	before_save :default_date

	def default_date
		self.remember_created_at ||= Date.today
		self.estado ||= "Pendiente"
	end
	

	def elevarEstado
		puts "SE ELEVA ESTADO"
		if(self.estado == "Pendiente")
			self.estado = "Aceptado"
		elsif (self.estado == "Aceptado")
			self.estado = "Vacunado"
		end
		self.save
	end

	def reducirEstado
		if(self.estado == "Aceptado")
			self.estado = "Pendiente"
			self.fechaRecibir=nil
		end
		self.save
	end

end
