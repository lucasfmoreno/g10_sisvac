class CreatePosta < ActiveRecord::Migration[6.1]
  def change
    create_table :posta do |t|
      t.string :nombre
      t.string :zona
      t.string :direccion
      ## Rememberable
      t.datetime :remember_created_at
    end
  end
end
