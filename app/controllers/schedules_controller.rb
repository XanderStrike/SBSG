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
  #   -if there's no employee who can take a shift, it fails silently and the shift doesn't show up
  #   -employees are assigned randomly, instead of intelligently
  #     i.e. if employee A has open availability and B can only close, A will sometimes be assigned
  #       the closing shift and nobody will be able to open
  #   -employees are sometimes assigned seven days in a row, or 40+ hours per week
  #   -
  # GET /schedules/generate
  def generate
    @employees = Employee.find_all_by_business_id(current_user.id)

    # initialize output hash
    output_emp = {}
    @employees.each do |e|
      output_emp[e.name] = "#{e.name}" 
    end

    # generate schedule
    7.times do |day|
      @emps = @employees.shuffle
      Shift.where(day: day, business_id: current_user.id).each do |s|
        @emps.each do |e|
          if e.can_work?(s)
            output_emp[e.name] += ",#{s.start.strftime("%I:%M%p")} - #{s.end.strftime("%I:%M%p")}"
            @emps.delete(e)
            break
          end
        end
      end
      @emps.each do |e|
        output_emp[e.name] += ",OFF"
      end
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

end
