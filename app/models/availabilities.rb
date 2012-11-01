class Availabilities < ActiveRecord::Base
  attr_accessible :employee_id, :start, :end, :day, :business_id
end
