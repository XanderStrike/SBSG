module BusinessesHelper
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in." 
    end
  end

  def correct_user
    @user = Businesses.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
