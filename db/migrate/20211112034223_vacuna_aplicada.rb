class VacunaAplicada < ActiveRecord::Migration[6.1]
  def change
    create_table :vacuna_dadas do |t|
      t.integer :user_id
      t.string :tipo_vacuna
      t.integer :dosis
      t.string :observacion
      t.string :fecha_solicitud
      t.string :fecha_dada
    ## Rememberable
      t.datetime :remember_created_at
    end
  end
end
