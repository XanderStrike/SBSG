class EmployeesController < ApplicationController
  before_filter :signed_in_user

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.find_all_by_business_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])
    @employee.business_id = current_user.id

    respond_to do |format|
      if @employee.save
        7.times do |index|
          availability = Availability.new(params[:availability][index.to_s])
          puts "params[:availability][#{index}]: #{params[:availability][index.to_s]}"
          availability.employee_id = @employee.id
          availability.day = index
          availability.business_id = current_user.id

          availability.save
        end

        format.html { redirect_to employees_path, notice: 'Employee was successfully created.' }
        format.json { render json: employees_path, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        availabilities = Availability.find_all_by_employee_id(@employee.id, order: 'day')
puts "availabilities: #{availabilities.inspect}"
        7.times do |index|
          availability = availabilities[index]
          availability.update_attributes(params[:availability][index.to_s])
#          availability.day = index
#          availability.business_id = current_user.id

          availability.save
        end

        format.html { redirect_to employees_path, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    @availabilities = Availability.find_all_by_employee_id(params[:id])
    @availabilities.each do |a|
      a.destroy
    end

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end
end
