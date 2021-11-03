class FechaLugarTurno < ActiveRecord::Migration[6.1]
  def change
    add_column :turnos, :fechaRecibir, :string
    add_column :turnos, :lugar, :string
  end
end
