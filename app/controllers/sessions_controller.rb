# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.blank?
      flash[:warning] = 'You need to create an account'
      redirect_to login_url
    elsif user&.authenticate(params[:session][:password])
      log_in user
      if user.activated?
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = 'Welcome back'
        redirect_back_or user
      else
        message  = 'Account not activated. '
        message += 'Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end
