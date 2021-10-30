class Checkbox < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :diabetico, :boolean
    add_column :users, :enfermedadCardio, :boolean
    add_column :users, :enfermedadCardioDesc, :string
    add_column :users, :Otros, :string
  end
end
