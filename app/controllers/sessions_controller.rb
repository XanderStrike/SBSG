class SessionsController < ApplicationController

  def new
    redirect_back_or 'shifts' if signed_in?
  end

  def create
    user = Business.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or 'shifts'
    else
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    render 'new'
  end
end
