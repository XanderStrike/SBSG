class Schedule < ActiveRecord::Base
  attr_accessible :schedule, :business_id

  def to_csv_em
    a = Assignment.find_all_by_schedule_id(id)
    csv_hash = {"1" => ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]}

    7.times do |day|
      days_assignments = a.select { |ass| Shift.find_by_id(ass.shift_id).day == day}
      days_assignments.each do |asn|
        e = Employee.find_by_id(asn.employee_id)
        s = Shift.find_by_id(asn.shift_id)
        csv_hash[e.name] = Array.new(7, "OFF") if csv_hash[e.name].nil?
        csv_hash[e.name][day] = s.times
      end
    end

    return to_csv(csv_hash)
  end

  def to_csv_sh

    a = Assignment.find_all_by_schedule_id(id)
    csv_hash = {"1" => ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]}

    weeks_assignments, count = [], Array.new(7, 0)
    7.times do |day|
      days_assignments = a.select { |ass| Shift.find_by_id(ass.shift_id).day == day}
      weeks_assignments << days_assignments
      count[day] = days_assignments.count
    end

    count.max.times do |x|
      csv_hash["#{x+2}"] = Array.new(7, "")
      7.times do |day|
        s = Shift.find_by_id(weeks_assignments[day][x].shift_id) rescue nil
        e = Employee.find_by_id(weeks_assignments[day][x].employee_id) rescue nil
        csv_hash["#{x+2}"][day] = "#{s.times} #{e.name}" unless s.nil?
      end
    end

    return to_csv(csv_hash)    
  end

  private

  def to_csv(hash)
    output = ""
    hash.keys.sort.each do |name|
      output += "#{name}," unless name.to_i > 0
      hash[name].each do |shift|
        output += "#{shift},"
      end
      output += ";"
    end

    return output
  end
end