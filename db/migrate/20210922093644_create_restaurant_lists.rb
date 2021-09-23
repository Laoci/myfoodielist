class CreateRestaurantLists < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurant_lists do |t|
      t.references :restaurant, foreign_key: true
      t.references :list, foreign_key: true
      t.timestamps
    end
  end
end
