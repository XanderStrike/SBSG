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

  def shift_availability
    shift_availability = []
    shifts = Shifts.find_by_business_id(business_id)

    shifts.each do |shift|
      if self.can_work?(shift)
        shift_availability << shift.id
      end
    end

    shift_availability
  end
end
