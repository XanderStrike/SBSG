require 'json'

class SchedulesController < ApplicationController
  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.find_all_by_business_id(current_user.id)
    @schedule = ""

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :no_content }
    end
  end

  

  # Problems with algorithm:
  #   -employees are assigned randomly, instead of intelligently
  #     i.e. if employee A has open availability and B can only close, A will sometimes be assigned
  #       the closing shift and nobody will be able to open
  #   -employees are sometimes assigned seven days in a row, or 40+ hours per week
  #   -we probably will want to hold the data temporarily in some better form than a string for
  #       checking things
  # GET /schedules/generate
  def generate
    @employees = Employee.find_all_by_business_id(current_user.id)
    @errors = []

    # initialize output hash
    length = {}

    # create schedule
    @schedule = Schedule.create(business_id: current_user.id)

    # generate schedule
    5.times do |x|
      @errors = []
      @employees.each do |e|
        length["#{e.name}"] = 0
      end

      7.times do |day|
        @emps = @employees.shuffle
        Shift.where(day: day, business_id: current_user.id).each do |s|
          assigned = false
          @emps.each do |e|
            if e.can_work?(s) && (length[e.name] + s.length) <= 40
              Assignment.create(schedule_id: @schedule.id, shift_id: s.id, employee_id: e.id)
              length[e.name] += s.length
              @emps.delete(e)
              assigned = true
              break
            end
          end
          @errors += ["Shift #{s.to_s} couldn't be assigned!"] unless assigned
        end
      end
      
      break if @errors.empty?
    end
  end

  def generate_new
    @employees = Employee.find_all_by_business_id(current_user.id)
    employee_availability_by_employee = {}
    employee_availability_by_shift = {}

    @employees.each do |employee|
      employee_availability_by_employee[employee.id.to_s] = employee.shift_availability
    end

    Shift.all.each do |shift|
      employees = []
      employee_availability_by_employee.keys.each do |employee|
        employees << employee if employee_availability_by_employee[employee].member?(shift.id)
      end

      employee_availability_by_shift[shift.id.to_s] = employees
    end

    solutions = possible_schedules([], employee_availability_by_shift.clone)

    @errors = []
    save_schedule(solutions[rand(solutions.length)])
  end

  def possible_schedules(partial_schedule, availabilities)
    stack = [{partial_schedule: partial_schedule, availabilities: availabilities}]
    solutions = []

    until stack.empty?
      context = stack.shift
      next_shift = context[:availabilities].first

      next_shift[1].each do |available_employee|
        shift_id = next_shift[0]
        next_partial_schedule = context[:partial_schedule].clone << [shift_id, available_employee]
        if context[:availabilities].size == 1
          solutions << next_partial_schedule
        else
puts "context[:availabilities]: #{context[:availabilities].inspect}"
          availabilities_clone = context[:availabilities].clone
          availabilities_clone.delete(shift_id)
puts "context[:availabilities]: #{context[:availabilities].inspect}"
          next_availabilities = remove_conflicting_shifts(available_employee, shift_id, availabilities_clone)

          stack << {partial_schedule: next_partial_schedule, availabilities: next_availabilities}
        end
      end
    end

    solutions
  end

  def remove_conflicting_shifts(employee_id, shift_id, availabilities)
puts "availabilities: #{availabilities.inspect}"
    shift = Shift.find(shift_id)
    #shift_availability = availabilities[shift_id.to_s]
puts "shift_id: #{shift_id}"
#puts "shift_availability: #{shift_availability.inspect}"
    potentially_conflicting_shifts = Shift.find_all_by_day_and_business_id(shift.day,shift.business_id)

    potentially_conflicting_shifts.each do |other_shift|
      if shift.contains?(other_shift) || (shift.length + other_shift.length > 8)
        availabilities[other_shift.id.to_s].delete(employee_id) unless availabilities[other_shift.id.to_s].nil?
      end
    end

    #availabilities[shift_id.to_s] = shift_availability
    availabilities
  end

  def save_schedule(schedule)
    @schedule = Schedule.new
    @schedule.business_id = current_user.id
    @schedule.save

    schedule.each do |filled_shift|
      assignment = Assignment.new(schedule_id: @schedule.id, shift_id: filled_shift[0], employee_id: filled_shift[1])
      assignment.save
    end
  end
end
