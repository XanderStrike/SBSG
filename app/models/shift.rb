class Shift < ActiveRecord::Base
  attr_accessible :start, :end, :day, :business_id
end
