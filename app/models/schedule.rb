require 'json'

class Schedule < ActiveRecord::Base
  attr_accessible :schedule, :business_id

  def emp2shift
    # This will be operating under the assumption schedule contains a json blob for all the days. DGAF.
    stuff = JSON.parse(self.schedule)
    new_arr = []

    stuff.count.times do |x|
      new_arr[x] = {}
      stuff[x].keys.each do |key|
        new_arr[x][stuff[x][key]] = key
      end
    end
    return new_arr
  end

  def to_csv_em
    array = self.emp2shift
    csv_hash = {}

    7.times do |day|
      array[day].keys.each do |e_id|
        e = Employee.find_by_id(e_id.to_i)
        s = Shift.find_by_id(array[day][e_id].to_i)
        csv_hash[e.name] = Array.new(7, "OFF") if csv_hash[e.name].nil?
        csv_hash[e.name][day] = s.times
      end
    end

    output = "e2s,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;"
    csv_hash.keys.sort.each do |name|
      output += ";#{name}"
      csv_hash[name].each do |shift|
        output += ",#{shift}"
      end
    end

    return output
  end

  # Delicious code repetition. I'll fix this later.
  def to_csv_sh
    array = JSON.parse(self.schedule)
    csv_hash = {}

    7.times do |day|
      array[day].keys.each do |s_id|
        s = Shift.find_by_id(s_id.to_i)
        e = Employee.find_by_id(array[day][s_id].to_i)
        csv_hash[s.times] = Array.new(7, "N/A") if csv_hash[s.times].nil?
        csv_hash[s.times][day] = e.name
      end
    end

    output = "s2e,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;"
    csv_hash.keys.sort.each do |times|
      output += ";#{times}"
      csv_hash[times].each do |name|
        output += ",#{name}"
      end
    end

    return output
  end
end