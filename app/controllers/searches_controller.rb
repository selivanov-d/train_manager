class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def show_results
    @search = Search.new(search_params)
    @search.validate

    flash.alert = get_errors_as_array_of_strings_for(@search) if @search.invalid?
  end

  private

  def search_params
    params.require(:search).permit(:departure_station_id, :arrival_station_id)
  end
end
