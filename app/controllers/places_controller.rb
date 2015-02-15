class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:last_search] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
  def show
    @place = Rails.cache.read(session[:last_search].downcase).select { |p| p.id == params[:id] }.first
    render :show   
  end

end
