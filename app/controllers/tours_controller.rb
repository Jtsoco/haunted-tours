class ToursController < ApplicationController
  def index
    @tours = Tour.all
    @tours = policy_scope(Tour)
  end

  def new
  end

  def show
    @tour = Tour.find(params[:id])
    authorize @tour
  end

  def create
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :price, :description, :location, :photos)
  end
end
