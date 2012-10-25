class BusinessesController < ApplicationController
  def new
    @business = Business.new
  end

  def create
    @business = Business.new(params[:business])
    if @business.save
      sign_in @business
      flash[:success] = "Welcome to Stargate"
      redirect_to '/shifts'
    else
      render 'new'
    end
  end
end
