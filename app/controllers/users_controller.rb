class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def update
    @user = User.find_by(id: params[:id])
    authorize @user
    if @user
      @user.update!(user_params)
    else
      flash[:error] = "Could not find user with id: #{params[:id]}"
    end
    redirect_to users_path
  end

  def destroy
    @user = User.find_by(id: params[:id])
    authorize @user
    if @user
      @user.destroy
    else
      flash[:error] = "Could not find user with id: #{params[:id]}"
    end
    redirect_to users_path
  end

  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:commissioner, :admin, :confirmed_at)
    elsif current_user.commissioner
      params.require(:user).permit(:commissioner)
    end
  end
end
