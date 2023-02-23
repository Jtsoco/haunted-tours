class ChangeStatusDefaultInBookings < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :status, :integer, default: 0
  end
end
