class Turno < ApplicationRecord
	belongs_to :user, optional: true
	validates :tipovacuna, presence: true
end
