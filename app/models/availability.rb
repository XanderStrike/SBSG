class Availability < ActiveRecord::Base
  attr_accessible :employee_id, :start, :end, :day, :business_id

  # will determine if a shift is contained within the given availability
  def contains?(shift)
  	if (before?(self.start, shift.start) &&
  		before?(shift.end, self.end))
  	  true
  	else
  	  false
  	end
  end

  def available?
    start != self.end
  end

end
