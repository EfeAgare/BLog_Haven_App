# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index update_user destroy]
  before_action :correct_user,   only: [:update_user]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page],
                                                  per_page: 12)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    unless @user.activated
      redirect_to root_url
      flash[:info] = 'You need to activate your account to access this page'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Account created successfully and check your mail to activated your account'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
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

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
