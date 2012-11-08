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

  def before?(time1, time2)
  	if time1.hour < time2.hour
  	  true
  	elsif time1.hour == time2.hour
  	  if time1.min <= time2.min
  	  	true
  	  else
  	  	false
  	  end
  	else
  	  false
  	end
  end

end
