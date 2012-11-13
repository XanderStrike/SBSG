class Availability < ActiveRecord::Base
  attr_accessible :employee_id, :start, :end, :day, :business_id

  # will determine if a shift is contained within the given availability
  def contains?(shift)
  	before?(self.start, shift.start) && before?(shift.end, self.end)
  end

  def available?
    start != self.end
  end

  def before?(time1, time2)
  	time1.hour < time2.hour || time1.hour == time2.hour && time1.min <= time2.min
  end

end
