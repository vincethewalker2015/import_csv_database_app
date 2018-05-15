class DoctorsController < ApplicationController
  
  
  def index
    @doctors = Doctor.all
  end

  def import
    Doctor.import(params[:file])
    redirect_to root_url, notice: "Activity Data imported"
  end
end
