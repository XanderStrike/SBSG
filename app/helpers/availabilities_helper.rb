module AvailabilitiesHelper
  def before?(time1, time2)
    if time1.hour < time2.hour
      true
    elsif time1.hour == time2.hour && time1.min < time2.min
      true
    else
      false
    end 
  end
end
