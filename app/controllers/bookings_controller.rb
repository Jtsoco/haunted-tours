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
      @reviews = @tour.reviews
      @review = Review.new
      render "tours/show", status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize(@booking)
  end

  def update
    @booking = Booking.find(params[:id])
    # @booking.assign_attributes(booking_params)
    @booking.status = params[:booking][:status]
    authorize(@booking)
    if @booking.update(booking_params) && @booking.status != 'canceled'
      redirect_to hosted_tours_path(tab: 'booking'), status: :see_other
    elsif !@booking.update(booking_params) && @booking.status != 'canceled'
      render :hosted_tours
    elsif @booking.update(booking_params) && @booking.status == 'canceled'
      redirect_to bookings_path, status: :see_other
    else
      render :bookings
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :guests, :status)
  end
end
