class DashboardController < ApplicationController
  before_filter :signed_in_user

  def index
  	@debug = params.to_s
  	@schedules = Schedule.find_all_by_business_id(current_user.id)
  	@employees = Employee.find_all_by_business_id(current_user.id)
  	@shifts = Shift.find_all_by_business_id(current_user.id)
  end

  def reports
    @report = []
    schedule = Schedule.find_all_by_business_id(current_user.id).last

    employees = Employee.find_all_by_business_id(current_user.id)

    assignments = []
    employees.each do |e|
      hours_total = 0
      hours_week = 0
      Assignment.find_all_by_employee_id(e.id).each do |a|
        shift = Shift.find_by_id(a.shift_id)
        hours_total += shift.length
        hours_week += shift.length if a.schedule_id == schedule.id
      end
      assignments += [[e.name, hours_week, hours_total]]
    end


    
    @report = assignments

  end
end
