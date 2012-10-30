class AddBusinessIdToShiftsEmployeesSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :business_id, :integer
  	add_column :shifts, :business_id, :integer
  	add_column :employees, :business_id, :integer
  end
end
