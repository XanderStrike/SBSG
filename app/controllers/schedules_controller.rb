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

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
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

  # GET /schedules/generate
  def generate
    @schedule = Schedule.new

    @shifts = Shift.find_all_by_business_id(current_user.id)
    @employees = Employee.find_all_by_business_id(current_user.id)

    output_emp = {}

    days = [0,1,2,3,4,5,6]
    days.each do |day|
      @emps = @employees.shuffle
      Shift.where(day: day, business_id: current_user.id).each do |s|
        @emps.each do |e|
          if output_emp[e.name].nil?
            output_emp[e.name] = "#{e.name}" 
          end
          ava = Availability.where(day: day, employee_id: e.id)
          if ava.first.contains?(s)
            output_emp[e.name] += ",#{s.start.strftime("%I:%M%p")} - #{s.end.strftime("%I:%M%p")}"
            @emps.delete(e)
            break
          end
          # if there are no more employees, no one can take this shift so throw an error here
        end
      end
      @emps.each do |e|
        if output_emp[e.name].nil?
          output_emp[e.name] = "#{e.name}" 
        end
        output_emp[e.name] += ",OFF"
      end
    end

    output = ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;"
    output_emp.keys.each do |name|
      output += "#{output_emp[name]};"
    end


    @schedule.schedule = output
    @schedule.business_id = current_user.id
    @schedule.save

  end

end
