class PlacesController < ApplicationController
  def index
  end

  def show
    @places = BeermappingApi.places_in(session[:place_search])
    @place_id = params[:id]
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:place_search] = params[:city]
      render :index
    end
  end
end
