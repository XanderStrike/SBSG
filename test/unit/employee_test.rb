require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


#not sure about test_employee?
  def test_employee
    employee = Employee.new(business_id: 1, name: joe, email: joe@joe.com)

    assert employee.save!
    assert_equal joe, employee.name
  end

  def should_create_employee do
  	assert_difference('Employee.count') do
  		employee :create, :employee => { :name => 'Some Name'}
  	end

  	assert_redirect_to employee_path(assigns(:employee))
end


