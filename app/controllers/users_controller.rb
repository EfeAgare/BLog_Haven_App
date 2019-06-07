# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index update_user, :destroy]
  before_action :correct_user,   only: [:update_user]

  def index
    @users = User.paginate(page: params[:page], per_page: 12)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(params[:public_uid])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Account created successfully'
      redirect_back_or @user
    else
      render 'new'
    end
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  
  def update_user
    @user = User.find_by(params[:public_uid])
    if @user.update(user_update_params(params))
      render json: { message: 'Profile updated successfully' }
      redirect_to @user
    else
      render json: { message: 'Profile could not be updated' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params(params)
    {
      name: params['name'],
      email: params['email'],
      profession: params['profession'],
      bio: params['bio']
    }
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
