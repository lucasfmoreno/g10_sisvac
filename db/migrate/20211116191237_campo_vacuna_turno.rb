class CampoVacunaTurno < ActiveRecord::Migration[6.1]
  def change
    add_column :vacuna_dadas, :turno_id, :integer
  end
end
