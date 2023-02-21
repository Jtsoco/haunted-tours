class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.boolean :completed
      t.float :user_rating
      t.references :user, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
