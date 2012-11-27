require 'no_overtime_validator'

class Shift < ActiveRecord::Base
  attr_accessible :start, :end, :day, :business_id
  validates_with NoOvertimeValidator

  
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
