require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


#not finished!
  def test_business
  	business = Business.new(name: Test, email: test@test.com, password: isvalid?)
  	assert business.save!
  	assert_equal
  end


end
