require 'test_helper'
=begin
class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def test_employee
    employee = Employee.new(business_id: 1, name: joe, email: joe)

    assert employee.save!
    assert_equal joe, employee.name
  end

  def should_create_employee do
  	assert_difference('Employee.count') do
  		employee :create, :employee => { :name => 'Some Name'}
  	end
  	assert_redirect_to employee_path(assigns(:employee))
  end
  



  def test_employee__must_have_valid_email
    employee = Employee.new(business_id: 1, name: test,  email: test)

    exception = assert_raise ActiveRecord::RecordInvalid do
      employee.save!
    end
    assert_equal "Validation failed: Email is invalid.", exception.message
  end
end
=end



