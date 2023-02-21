class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    authorize @booking
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
