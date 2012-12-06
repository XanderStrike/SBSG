module SchedulesHelper
  def schedule_by_employee_csv(shift_assignments, employee_assignments)
    csv_hash = {"1" => ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]}

    7.times do |day|
      shift_assignments[day].count.times do |assignment|
        employee = Employee.find(employee_assignments[day][assignment])
        shift = Shift.find(shift_assignments[day][assignment])
        csv_hash[employee.name] = Array.new(7, "OFF") if csv_hash[employee.name].nil?
        csv_hash[employee.name][day] = shift.times
      end
    end

    return to_csv(csv_hash)
  end

  def schedule_by_shift_csv(shift_assignments, employee_assignments)
    csv_hash = {"1" => ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]}

    count = Array.new(7, 0)
    7.times do |day|
      count[day] = shift_assignments[day].count
    end

    count.max.times do |n|
      csv_hash["#{n+2}"] = Array.new(7, "")
      7.times do |day|
        shift = Shift.find(shift_assignments[day][n]) rescue nil
        employee = Employee.find(employee_assignments[day][n]) rescue nil
        csv_hash["#{n+2}"][day] = "#{shift.times} #{employee.name}" unless shift.nil?
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
