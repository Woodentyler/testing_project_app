class UsersController < ApplicationController

  def new
    render :new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to root
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find_by(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
