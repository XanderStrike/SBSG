class Shift < ActiveRecord::Base
  attr_accessible :fri_end, :fri_start, :mon_end, :mon_start, :sat_end, :sat_start, :sun_end, :sun_start, :thu_end, :thu_start, :tue_end, :tue_start, :wed_end, :wed_start
end
