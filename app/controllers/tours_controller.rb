class ToursController < ApplicationController
  def index
    @tours = Tour.all
  end

  def new
  end

  def create
  end
end
