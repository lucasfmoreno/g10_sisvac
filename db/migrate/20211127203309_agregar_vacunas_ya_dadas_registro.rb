class AgregarVacunasYaDadasRegistro < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :se_puso_covid, :boolean
    add_column :users, :dosis_covid, :integer
    add_column :users, :se_puso_gripe, :boolean
    add_column :users, :fecha_gripe, :string
  end
end
