class Employee < ActiveRecord::Base
  attr_accessible :name, :email, :business_id

  # Determines if an employee can work a given shift.
  # Sexy.
  def can_work?(shift)
  	avas = Availability.where(employee_id: id, day: shift.day)
  	avas.each do |a|
  		if a.contains?(shift)
  			return true
  		end
  	end
  	return false
  end
end
