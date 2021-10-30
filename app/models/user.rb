class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :turnos
  before_save :default_rol
  def default_rol
    self.rol ||= "Paciente"
  end
  validates :dni, uniqueness: true;
  
end
