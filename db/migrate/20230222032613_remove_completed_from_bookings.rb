class RemoveCompletedFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :completed
  end
end
