class Employee < ActiveRecord::Base
  attr_accessible :name, :email, :business_id
end
