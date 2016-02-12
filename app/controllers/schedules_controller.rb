class SchedulesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @schedules = Schedule.all
    authorize @schedules
  end

  def new
    authorize Schedule.new
  end

  def create
    base_time = Time.zone.parse(params['date'])
    params['schedule'] = {}
    params['schedule']['start_time'] = Time.zone.parse(params['start_time'], base_time)
    params['schedule']['end_time'] = Time.zone.parse(params['end_time'], base_time)
    @schedule = Schedule.new(schedule_params)
    authorize @schedule
    if @schedule.save
      redirect_to games_schedule_week_path({params: {schedule_id: @schedule.id}})
    else
      flash[:error] = "Could not create time for #{params['schedule']['start_time'].start_time.to_s(:feedback)}"
      redirect_to :back
    end

  end

  # TODO edit

  def destroy
    @schedule = Schedule.find_by(id: params[:id])
    authorize @schedule
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
