class CarriagesController < ApplicationController
  def show
    @carriage = Carriage.find(params[:id])

    render :show, locals: { class_snake_case: @carriage.class_name_in_snake_case }
  end
end
