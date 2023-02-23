class ToursController < ApplicationController
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
    @tour = Tour.new
    @bookings = current_user.bookings_as_owner
    authorize @tour
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :price, :description, :location, :photos)
  end
end
