class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :name, default: "New List", null: false
      t.boolean :shared, default: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
