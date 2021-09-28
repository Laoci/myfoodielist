class AddCoodinatesToRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :coordinates, :string, null: false
  end
end
