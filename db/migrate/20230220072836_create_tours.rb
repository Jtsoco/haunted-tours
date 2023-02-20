class CreateTours < ActiveRecord::Migration[7.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
