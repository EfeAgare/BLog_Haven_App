# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[show_micropost destroy]
  before_action :correct_user,   only: :destroy

  def new
    @micropost = current_user.microposts.build if logged_in?
  end

  def show_micropost
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def create_micropost
    @micropost = current_user.microposts.build(content: params[:content])
    if @micropost.save
      render json: { message: 'Micropost created successfully' }
    else
      render json: { message: 'An error occurred' }
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
