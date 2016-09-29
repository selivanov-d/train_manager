class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'Пользователь успешно создан!'
    else
      flash.alert = get_errors_as_array_of_strings_for(@user)
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Пользователь успешно обновлён!'
    else
      flash.alert = get_errors_as_array_of_strings_for(@user)
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Пользователь удалён!'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :family_name)
  end
end
