class DashboardController < ApplicationController
  before_filter :signed_in_user

  def index
  	@debug = params.to_s
  	@schedules = Schedule.find_all_by_business_id(current_user.id)
  	@employees = Employee.find_all_by_business_id(current_user.id)
  	@shifts = Shift.find_all_by_business_id(current_user.id)
  end
end
