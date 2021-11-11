class User < ApplicationRecord
  has_many :turnos
  has_one :search
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable 
  before_save :default_rol
  def default_rol
    self.rol ||= "Paciente"
  end
  validates :dni, uniqueness: true,presence: true
  validates :direccion, presence: true
  validates :edad, presence:true
  
end
