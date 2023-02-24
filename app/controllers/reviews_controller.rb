class ReviewsController < ApplicationController

  def create

    @review = Review.new(review_params)
    @tour = Tour.find(params[:tour_id])
    @review.user = current_user
    @review.tour = @tour
    @review.time = DateTime.now
    authorize @review
    if @review.save
      redirect_to tour_path(@tour)
    else
      @reviews = @tour.reviews
      render "tours/show", status: :unprocessable_entity
    end

  end

  private

  def review_params
    params.require(:review).permit(:comment, :time)
  end
end
