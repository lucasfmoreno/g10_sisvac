class Turno < ApplicationRecord
	belongs_to :user, optional: true
	validates :usuario_id, :tipovacuna, presence: true
end
