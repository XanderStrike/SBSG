require 'no_overtime_validator'

class Shift < ActiveRecord::Base
  attr_accessible :start, :end, :day, :business_id

  validates :day, inclusion: {in: [0,1,2,3,4,5,6], message: "is invalid."}
  validates_with NoOvertimeValidator

  
  def contains?(shift)
    before?(self.start, shift.start) && before?(shift.end, self.end)
  end

  def before?(time1, time2)
    time1.hour < time2.hour || time1.hour == time2.hour && time1.min <= time2.min
  end

  def length
  	(self.end - self.start) / 3600
  end

  def to_s
  	days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  	"#{days[self.day]}: #{self.start.strftime("%I:%M%p")}-#{self.end.strftime("%I:%M%p")}"
  end

  def times
    "#{self.start.strftime("%I:%M%p")}-#{self.end.strftime("%I:%M%p")}"
  end
end
