class UsersController < ApplicationController
  before_filter :authenticate!, except: [:new, :create]
  before_filter :authorize_admin!, only: :update
  before_filter :check_for_signup!, only: [:new, :create]
  
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

  def update
    find_user

    @user.admin = params[:admin]
    if @user.save
      redirect_to user_path(@user)
    else
      render :show
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
  end

  def authorize_admin!
    if !current_user.admin?
      flash[:notice] = "Please check to make sure you have proper permissions."
      redirect_to user_path(@user)
    end
  end

  def check_for_signup!
    if signup_disallowed?
      flash[:notice] = "The owner has disabled new signups on this Query Clips instance."
      redirect_to root_path
    end
  end
end
