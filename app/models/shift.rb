require 'no_overtime_validator'

class Shift < ActiveRecord::Base
  attr_accessible :start, :end, :day, :business_id

  validates_with NoOvertimeValidator
end
