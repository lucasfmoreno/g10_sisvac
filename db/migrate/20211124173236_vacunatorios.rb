class Vacunatorios < ActiveRecord::Migration[6.1]
  def change
    create_table :vacunatorios do |t|
      t.string :nombre
      t.string :zona
      t.string :direccion
      ## Rememberable
      t.datetime :remember_created_at
    end
  end
end
