class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
  end


  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @tour = Tour.find(params[:tour_id])
    @booking.user = current_user
    @booking.tour = @tour
    authorize @booking
    if @booking.save
      redirect_to bookings_path
    else
      render "tours/show", status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = params[:booking][:status]

    if @booking.update(booking_params)
      redirect_to hosted_tours_path(tab: 'booking'), status: :see_other
      # possibly make anew route to allow tab redirects?
    else
      render :hosted_tours, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :guests, :status)
  end
end
