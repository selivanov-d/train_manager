class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def show_results
    @search = Search.new(search_params)

    if @search.invalid?
      flash.alert = get_errors_as_array_of_strings_for(@search)
      redirect_to new_search_path
    end

    @search.result = @search.make_search
  end

  private

  def search_params
    params.require(:search).permit(:departure_station_id, :arrival_station_id)
  end
end
