require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  def test_shift
    shift = Shift.new(business_id: 1, day: 5, start: (Time.now.midnight + 2*60*60), :end => (Time.now.midnight + 6*60*60))

    assert shift.save!
    assert_equal 4, shift.length
  end

  def test_shift__shift_can_be_eight_hours
    shift = Shift.new(business_id: 1, day: 0, start: (Time.now.midnight + 6*60*60), :end => (Time.now.midnight + 14*60*60))

    assert shift.save!
    assert_equal 8, shift.length
  end

  def test_shift__must_have_valid_day
    shift = Shift.new(business_id: 1, day: 8, start: (Time.now.midnight + 6*60*60), :end => (Time.now.midnight + 13*60*60))

    exception = assert_raise ActiveRecord::RecordInvalid do
      shift.save!
    end

    assert_equal "Validation failed: Day is invalid.", exception.message
  end

  def test_no_overtime_validator__shift_length_cant_be_negative
    shift = Shift.new(business_id: 1, day: 6, start: (Time.now.midnight + 2*60*60), :end => Time.now.midnight)
    
    exception = assert_raise ActiveRecord::RecordInvalid do
      shift.save!
    end

    assert_equal "Validation failed: Shift end must be after shift start.", exception.message
  end

  def test_no_overtime_validator__shift_length_cant_be_zero
    shift = Shift.new(business_id: 1, day: 3, start: Time.now.midnight, :end => Time.now.midnight)
    
    exception = assert_raise ActiveRecord::RecordInvalid do
      shift.save!
    end

    assert_equal "Validation failed: Shift end must be after shift start.", exception.message
    assert_equal 0, shift.length
  end

  def test_no_overtime_validator__shift_cant_be_longer_than_eight_hours
    long_shift = Shift.new(business_id: 1, day: 3, start: Time.now.midnight, :end => (Time.now.midnight + 9*60*60))

    exception = assert_raise ActiveRecord::RecordInvalid do
      long_shift.save!
    end

    assert_equal "Validation failed: Shifts can't be longer than eight hours.", exception.message
    assert_equal 9, long_shift.length
  end
end
