# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def authenticated
    user = User.find_by(id: session[:user_id])
    if user.activated?
      return true
    else
      flash[:danger] = 'You can perform this action'
    end
  end

end
