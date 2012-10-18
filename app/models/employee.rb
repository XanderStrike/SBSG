class Employee < ActiveRecord::Base
  attr_accessible :days_off, :fri_end, :fri_start, :mon_end, :mon_start, :name, :sat_end, :sat_start, :sun_end, :sun_start, :thu_end, :thu_start, :tue_end, :tue_start, :wed_end, :wed_start
end
