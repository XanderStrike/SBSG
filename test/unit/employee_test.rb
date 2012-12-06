require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def test_employee
    employee = Employee.new(business_id: 1, name: "joe", email: "joe")

    assert employee.save!
    assert_equal "joe", employee.name
  end
=begin
  def should_create_employee do
  	assert_difference('Employee.count') do
  		employee :create, :employee => { :name => 'Some Name'}
  	end
  	assert_redirect_to employee_path(assigns(:employee))
  end
  

=end

  def test_employee__must_have_valid_email
    employee = Employee.new(business_id: 1, name: "test",  email: "test@test.com")

    #exception = assert_raise ActiveRecord::RecordInvalid do
      employee.save!
   # end
    #assert_equal "Validation failed: Email is invalid.", exception.message
    assert_equal "test@test.com", employee.email
  end

  def test_employee__must_have_valid_name
    employee = Employee.new(business_id: 1, name: "test",  email: "test@test.com")

    #exception = assert_raise ActiveRecord::RecordInvalid do
      employee.save!
   # end
    #assert_equal "Validation failed: Email is invalid.", exception.message
    assert_equal "test", employee.name
  end





end
