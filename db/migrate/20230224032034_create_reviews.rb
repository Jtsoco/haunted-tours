class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
