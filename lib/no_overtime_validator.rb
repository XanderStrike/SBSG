class NoOvertimeValidator < ActiveModel::Validator
  def validate(record)
    if record.end - record.start > 8 
      record.errors[:base] << "Shifts can't be longer than eight hours"
    end
  end
end
