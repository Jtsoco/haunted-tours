class ToursController < ApplicationController
  def index
  end

  def new
  end

  def show
    @tour = Tour.find(params[:id])
  end

  def create

  end
end
