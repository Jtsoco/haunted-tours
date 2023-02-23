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
    authorize @tour
    if @tour.save
      redirect_to hosted_tours
    else
      render 'hosted_tours', status: :unprocessable_entity
    end
  end

  def hosted_tours

    @tours = current_user.tours
    @bookings = policy_scope([:host, Booking])
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :price, :description, :location, :photos)
  end
end
