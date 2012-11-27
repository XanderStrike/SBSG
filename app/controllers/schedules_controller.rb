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
    output_emp, length = {}, {}

    # generate schedule
    5.times do |x|
      @errors = []
      @employees.each do |e|
        output_emp[e.name] = "#{e.name}"
        length["#{e.name}"] = 0
      end

      7.times do |day|
        @emps = @employees.shuffle
        Shift.where(day: day, business_id: current_user.id).each do |s|
          assigned = false
          @emps.each do |e|
            if e.can_work?(s) && (length[e.name] + s.length) <= 40
              output_emp[e.name] += ",#{s.start.strftime("%I:%M%p")} - #{s.end.strftime("%I:%M%p")}"
              length[e.name] += s.length
              @emps.delete(e)
              assigned = true
              break
            end
          end
          @errors += ["Shift #{s.to_s} couldn't be assigned!"] unless assigned
        end
        @emps.each do |e|
          output_emp[e.name] += ",OFF"
        end
      end
      break if @errors.empty?
    end

    # csvify hash for schedule
    output = ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;"
    output_emp.keys.sort.each do |name|
      output += "#{output_emp[name]};"
    end

    # save the new schedule
    @schedule = Schedule.new
    @schedule.schedule = output
    @schedule.business_id = current_user.id
    @schedule.save

  end

  def generate_schedule
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

    solution = possible_schedules([], employee_availability_by_shift.drop(0))
  end

  def possible_schedules(partial_schedule, availabilities)
    stack = [{partial_schedule: partial_schedule, availabilities: availabilities}]
    solutions = []

    until stack.empty?
      context = stack.shift
puts "context: #{context.inspect}"
      next_shift = context[:availabilities].first

      next_shift[1].each do |available_employee|
        next_partial_schedule = context[:partial_schedule].drop(0) << [next_shift[0], available_employee]
        if context[:availabilities].size == 1
          solutions << next_partial_schedule
        else
          stack << {partial_schedule: next_partial_schedule, availabilities: context[:availabilities].drop(1)}
        end
      end
    end

    save_schedule(solutions[rand(solutions.length)])
  end

  def save_schedule(schedule)
    schedule_hash = {}
    schedule.each do |filled_shift|
      schedule_hash[filled_shift[0]] = filled_shift[1]
    end

    @schedule = Schedule.new
    @schedule.monday = shifts_for_day(schedule_hash, 0)
    @schedule.tuesday = shifts_for_day(schedule_hash, 1)
    @schedule.wednesday = shifts_for_day(schedule_hash, 2)
    @schedule.thursday = shifts_for_day(schedule_hash, 3)
    @schedule.friday = shifts_for_day(schedule_hash, 4)
    @schedule.saturday = shifts_for_day(schedule_hash, 5)
    @schedule.sunday = shifts_for_day(schedule_hash, 6)
    @schedule.business_id = current_user.id
    @schedule.save
  end

  def shifts_for_day(schedule, day)
    shifts_for_day = {}

    Shift.find_all_by_day(day).each do |shift|
      shifts_for_day[shift.id.to_s] = schedule[shift.id.to_s]
    end

    shifts_for_day
  end
end
