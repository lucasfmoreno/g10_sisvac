class User < ApplicationRecord
  validates :dni, uniqueness: true,presence: true
  validates :direccion, presence: true
  validates :vacunatorio, presence:true
  validates :edad, presence:true

  has_many :turnos
  has_one :search
  has_many :vacuna_dadas
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :authentication_keys => [:nroref, :dni]
        
  before_save :default_rol, :asignar_nroTram

  def default_rol
    self.rol ||= "Paciente"
  end

  def asignar_nroTram
    nroRandom = rand(1000..9999)
    puts "Genere nro random #{nroRandom}"
    if(self.nroref == nil)
      puts "Seteo nro random #{nroRandom}"
      self.nroref = nroRandom
    end
  end
  
end
