require 'test_helper'

class ShiftsControllerTest < ActionController::TestCase
  setup do
    @shift = shifts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shifts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shift" do
    assert_difference('Shift.count') do
      post :create, shift: { fri_end: @shift.fri_end, fri_start: @shift.fri_start, mon_end: @shift.mon_end, mon_start: @shift.mon_start, sat_end: @shift.sat_end, sat_start: @shift.sat_start, sun_end: @shift.sun_end, sun_start: @shift.sun_start, thu_end: @shift.thu_end, thu_start: @shift.thu_start, tue_end: @shift.tue_end, tue_start: @shift.tue_start, wed_end: @shift.wed_end, wed_start: @shift.wed_start }
    end

    assert_redirected_to shift_path(assigns(:shift))
  end

  test "should show shift" do
    get :show, id: @shift
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shift
    assert_response :success
  end

  test "should update shift" do
    put :update, id: @shift, shift: { fri_end: @shift.fri_end, fri_start: @shift.fri_start, mon_end: @shift.mon_end, mon_start: @shift.mon_start, sat_end: @shift.sat_end, sat_start: @shift.sat_start, sun_end: @shift.sun_end, sun_start: @shift.sun_start, thu_end: @shift.thu_end, thu_start: @shift.thu_start, tue_end: @shift.tue_end, tue_start: @shift.tue_start, wed_end: @shift.wed_end, wed_start: @shift.wed_start }
    assert_redirected_to shift_path(assigns(:shift))
  end

  test "should destroy shift" do
    assert_difference('Shift.count', -1) do
      delete :destroy, id: @shift
    end

    assert_redirected_to shifts_path
  end
end
