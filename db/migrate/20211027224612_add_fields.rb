class AddFields < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nombre, :string
    add_column :users, :apellido, :string
    add_column :users, :dni, :integer
    add_column :users, :direccion, :string
  end
end
