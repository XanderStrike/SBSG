require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
#attr_accessible :name, :email, :password, :password_confirmation, :current_schedule_id

test "Business attributes must not be empty" do
	business = Business.new
	#assert business.presence:true
	#assert business.errors[:email].any?
	#assert business.errors[:name].any?
  #assert business.errors[:password].any?
  #assert business.errors[:password_confirmation].any?
  #assert business.errors[:current_schedule_id].any?
end





  def test_business
  	business = Business.new(name: "Test", email: "test@test.com", password: "test_pass", password_confirmation: "test_pass", current_schedule_id: 1)  
  	assert business.save!
  	assert_equal "Test", business.name #not sure about this
  end



def test_business__must_have_valid_email
    business = Business.new(name: "test",  email: "test@test.com", password: "test_pass", password_confirmation: "test_pass", current_schedule_id: 1)

    #exception = assert_raise ActiveRecord::RecordInvalid do
      business.save!
    #end
    #assert_equal "Validation failed: Email is invalid.", exception.message
    assert_equal "test@test.com", business.email
  end

end