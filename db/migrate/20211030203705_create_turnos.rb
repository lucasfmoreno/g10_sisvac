class CreateTurnos < ActiveRecord::Migration[6.1]
  def change
    create_table :turnos do |t|
      t.integer :user_id
      t.string :tipovacuna
      t.string :observacion
    ## Rememberable
      t.datetime :remember_created_at
    end
  end
end
