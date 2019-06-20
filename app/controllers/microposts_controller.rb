class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @micropost = current_user.microposts.build if logged_in?
  end

  def create
    @micropost = current_user.micropost.build(micropost_params)
    if @micropost.save
      flash[:notice] = "Micropost successfully created"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
