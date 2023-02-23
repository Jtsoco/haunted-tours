class ChangeStatusToIntegerInBookings < ActiveRecord::Migration[7.0]
  def change
    change_column(:bookings, :status, 'integer USING CAST(status AS integer)')
  end
end
