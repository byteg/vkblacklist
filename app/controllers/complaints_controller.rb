class ComplaintsController < ApplicationController

  def new
  	@complaint = Complaint.new
  end

  # POST /groups
  # POST /groups.json
  def create
    puts complaint_params.inspect
    @complaint = Complaint.new(complaint_params)

    respond_to do |format|
      if @complaint.save
        format.html { redirect_to @complaint, notice: 'Group was successfully created.' }
        format.json { render json: @complaint, status: :created, location: @complaint }
      else
        format.html { render action: "new" }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end 

  def complaint_params
    params.require(:complaint).permit(:url, :account_id)
  end

end
