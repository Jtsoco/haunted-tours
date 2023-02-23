class ToursController < ApplicationController
  skip_after_action :verify_authorized, only: :hosted_tours

  def index
    @tours = Tour.all
    @tours = policy_scope(Tour)
  end

  def new
    @tour = Tour.new
  end

  def show
    @tour = Tour.find(params[:id])
    authorize @tour
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.user = current_user
    @tours = current_user.tours
    # All this extra stuff, bookings to rejection
    # it's there to make sure it loads on
    # the hosted_tours page
    # if it fails to save
    @bookings = policy_scope([:host, Booking])
    @pending = @bookings.where(status: 'pending')
    @accepted = @bookings.where(status: 'accepted')
    @rejected = @bookings.where(status: 'rejected')
    authorize @tour
    if @tour.save
      redirect_to :hosted_tours
    else
      @tab = 'new-tab'
      render 'hosted_tours', status: :unprocessable_entity
    end
  end
  
  def hosted_tours
    @tour = Tour.new
    @tours = current_user.tours
    @bookings = policy_scope([:host, Booking])
    @pending = @bookings.where(status: 'pending')
    @accepted = @bookings.where(status: 'accepted')
    @rejected = @bookings.where(status: 'rejected')
  end

  private

  def tour_params
    # in permitted params, :photos must be photos: []
    # If not file upload doesn't work!
    params.require(:tour).permit(:name, :price, :description, :location, photos: [])
  end
end
