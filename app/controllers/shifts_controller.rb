class ShiftsController < ApplicationController
  before_filter :signed_in_user

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts_old = Shift.find_all_by_business_id(current_user.id)

    @shifts = []
    @count = []

    7.times do |day|
      @shifts[day] = Shift.order("start desc").where(business_id: current_user.id, day: day)
      @count[day] = @shifts[day].count
    end

    @count = @count.max

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shifts }
    end
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end

  # GET /shifts/new
  # GET /shifts/new.json
  def new
    @shift = Shift.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shift }
    end
  end

  # GET /shifts/1/edit
  def edit
    @shift = Shift.find(params[:id])
  end

  # POST /shifts
  # POST /shifts.json
  def create
  
	days = params[:day]
	saved = true
  
	days.each do |d|
		@shift = Shift.new(params[:shift])
		@shift.business_id = current_user.id
		@shift.day = d[0]

	  if !@shift.save
		saved = false
	  end
	end
	
	respond_to do |format|
		if saved
			format.html { redirect_to shifts_path, notice: 'Shift was successfully created.' }
			format.json { render json: shifts_path, status: :created, location: @shift }
		else
			format.html { render action: "new" }
			format.json { render json: @shift.errors, status: :unprocessable_entity }
		end
	end
	
  end

  # PUT /shifts/1
  # PUT /shifts/1.json
  def update
    @shift = Shift.find(params[:id])

    respond_to do |format|
      if @shift.update_attributes(params[:shift])
        @shift.day = params[:day]

        format.html { redirect_to shifts_path, notice: 'Shift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy

    respond_to do |format|
      format.html { redirect_to shifts_url }
      format.json { head :no_content }
    end
  end
end
