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

  def hosted_tours
    @tours = Tour.where(id: params[:user_id])
    # authorize @tour
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :price, :description, :location, :photos)
  end
end
