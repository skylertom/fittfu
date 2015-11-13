class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
  end

  def create
    base_time = Time.zone.parse(params['date'])
    params['schedule'] = {}
    params['schedule']['start_time'] = Time.zone.parse(params['start_time'], base_time)
    params['schedule']['end_time'] = Time.zone.parse(params['end_time'], base_time)
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      flash[:success] = "Created event starting at #{@schedule.start_time.to_s(:feedback)}"
    else
      flash[:error] = "Could not create time for #{params['schedule']['start_time'].start_time.to_s(:feedback)}"
    end
    redirect_to new_schedule_path
  end

  # TODO edit

  def destroy
    @schedule = Schedule.find_by(id: params[:id])
    if @schedule
      @schedule.destroy
    else
      flash[:error] = "Could not find schedule with id: #{params[:id]}"
    end
    redirect_to schedules_path
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time)
  end
end
