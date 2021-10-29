class AddNumero < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nroref, :integer
  end
end
