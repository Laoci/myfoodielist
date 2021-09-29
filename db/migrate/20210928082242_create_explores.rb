class CreateExplores < ActiveRecord::Migration[6.1]
  def change
    create_table :explores do |t|
      t.boolean :explored, :default => false
      t.references :restaurant, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
