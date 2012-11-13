class Shift < ActiveRecord::Base
  attr_accessible :start, :end, :day, :business_id

  def length
  	(self.end - self.start) / 3600
  end

  def to_s
  	days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  	"#{self.start.strftime("%I:%M%p")} - #{self.end.strftime("%I:%M%p")}, #{days[self.day]}"
  end
end
