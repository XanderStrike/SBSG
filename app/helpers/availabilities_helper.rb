module AvailabilitiesHelper
  def before?(time1, time2)
    time1.hour < time2.hour || time1.hour == time2.hour && time1.min < time2.min
  end
end
