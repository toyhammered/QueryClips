class UsersController < ApplicationController
  before_filter :authenticate!, except: [:new, :create]
  
  def index
    @users = User.all
  end

  def show
    find_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    admin_hook
    if @user.save
      log_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def admin_hook
    if User.count < 1
      @user.admin = true
    end
  end

  def find_user
    @user = User.find(params[:id])
    if @user.nil?

    end
  end
end
