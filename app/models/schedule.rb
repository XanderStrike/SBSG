class Schedule < ActiveRecord::Base
  include SchedulesHelper

  attr_accessible :schedule, :business_id
  before_destroy :kill_assignments

  def kill_assignments
    asnmnts = Assignment.find_all_by_schedule_id(self.id)
    asnmnts.each do |a|
      a.destroy
    end
  end

  def to_csv_em
    assignments = Assignment.find_all_by_schedule_id(id)
    shift_assignments, employee_assignments = [], []

    7.times do |day|
      days_assignments = assignments.select {|assignment| Shift.find(assignment.shift_id).day == day}
      shift_assignments << days_assignments.map {|assignment| assignment.shift_id}
      employee_assignments << days_assignments.map {|assignment| assignment.employee_id}
    end
    
    schedule_by_employee_csv(shift_assignments, employee_assignments)
  end

  def to_csv_sh
    assignments = Assignment.find_all_by_schedule_id(id)
    shift_assignments, employee_assignments = [], []

    7.times do |day|
      days_assignments = assignments.select { |assignment| Shift.find(assignment.shift_id).day == day}
      shift_assignments << days_assignments.map {|assignment| assignment.shift_id}
      employee_assignments << days_assignments.map {|assignment| assignment.employee_id}
    end
    
    schedule_by_shift_csv(shift_assignments, employee_assignments)
  end

  def unfilled_positions
	
  end
  
  def pretty_date
	return created_at.localtime.strftime("%A, %D at %I:%Mp")
  end
end
