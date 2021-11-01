class EstadoTurno < ActiveRecord::Migration[6.1]
  def change
    add_column :turnos, :estado, :string
  end
end
