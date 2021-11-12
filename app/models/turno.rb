class Turno < ApplicationRecord
	belongs_to :user, optional: true
	validates :tipovacuna, presence: true
	before_save :default_date

	def default_date
		self.remember_created_at ||= Date.today
		self.estado ||= "Pendiente"
	end

end
