# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # Log the user in and redirect to user's show page
      log_in user
      remember user
      current_user = user
      redirect_to root_path
    # render 'new'
    else
      # Create a error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def logout
    log_out if logged_in?
    redirect_to root_url
  end
end
