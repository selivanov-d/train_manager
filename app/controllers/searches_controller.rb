class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def show_results
    @search = Search.new(search_params)

    @search.result = @search.make_search if @search.valid?
  end

  private

  def search_params
    params.require(:search).permit(:departure_station_id, :arrival_station_id)
  end
end
