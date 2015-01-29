class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    if Beer.exists?(id:params[:rating][:beer_id])
      Rating.create params.require(:rating).permit(:score, :beer_id)
      redirect_to ratings_path
    else
      redirect_to beers_path
    end
  end
  
  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end
