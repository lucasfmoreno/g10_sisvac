class VacunaDada < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :turno
    validates :tipo_vacuna, presence: true, allow_blank: false

    before_save :ponerFecha

    def ponerFecha
        self.fecha_dada = Date.today
    end
    
end
