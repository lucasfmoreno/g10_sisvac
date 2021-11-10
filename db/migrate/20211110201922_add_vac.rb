class AddVac < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :vacunatorio, :string
  end
end
