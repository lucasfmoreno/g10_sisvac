class Posta < ApplicationRecord
    validates :direccion, presence: true
    validates :nombre, presence: true
end
