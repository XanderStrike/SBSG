require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def test_schedule
    schedule = Schedule.new(schedule: 1, business_id: 5)

    assert schedule.save!
    assert_equal 5, schedule.business_id #not sure about this
  end

=begin
  def test_schedule__must_have_valid_schedule
    shift = Shift.new(business_id: 5, schedule:1)

    exception = assert_raise ActiveRecord::RecordInvalid do
      schedule.save!
    end

    assert_equal "Validation failed: Schedule is invalid.", exception.message
  end
=end

end
