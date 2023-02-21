class ToursController < ApplicationController
  def index
    authorize @tour
  end

  def new
  end

  def show
    @tour = Tour.find(params[:id])
  end

  def create
  end

  def show
    authorize @tour
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :price, :description, :location)
  end
end
