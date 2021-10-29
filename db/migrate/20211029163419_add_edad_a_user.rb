class AddEdadAUser < ActiveRecord::Migration[6.1]
  def change
    add_column :User, :edad, :integer
  end
end
