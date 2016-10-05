class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Ваш профиль успешно обновлён!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :family_name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
