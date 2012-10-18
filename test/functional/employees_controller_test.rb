require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post :create, employee: { days_off: @employee.days_off, fri_end: @employee.fri_end, fri_start: @employee.fri_start, mon_end: @employee.mon_end, mon_start: @employee.mon_start, name: @employee.name, sat_end: @employee.sat_end, sat_start: @employee.sat_start, sun_end: @employee.sun_end, sun_start: @employee.sun_start, thu_end: @employee.thu_end, thu_start: @employee.thu_start, tue_end: @employee.tue_end, tue_start: @employee.tue_start, wed_end: @employee.wed_end, wed_start: @employee.wed_start }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should show employee" do
    get :show, id: @employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee
    assert_response :success
  end

  test "should update employee" do
    put :update, id: @employee, employee: { days_off: @employee.days_off, fri_end: @employee.fri_end, fri_start: @employee.fri_start, mon_end: @employee.mon_end, mon_start: @employee.mon_start, name: @employee.name, sat_end: @employee.sat_end, sat_start: @employee.sat_start, sun_end: @employee.sun_end, sun_start: @employee.sun_start, thu_end: @employee.thu_end, thu_start: @employee.thu_start, tue_end: @employee.tue_end, tue_start: @employee.tue_start, wed_end: @employee.wed_end, wed_start: @employee.wed_start }
    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete :destroy, id: @employee
    end

    assert_redirected_to employees_path
  end
end
