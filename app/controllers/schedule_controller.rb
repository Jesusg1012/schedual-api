class ScheduleController < ApplicationController
  def index
    render json: { schedules: Schedule.all}, status: :accepted
  end
  def show
    @schedule = Schedule.find(params[:id])
    if @schedule
      render json: { schedule: ScheduleSerializer.new(@schedule) }, status: :accepted
    else
      render json: { message: 'schedule not found' }, status: :not_found
    end
  end

  def create
    @schedule = Schedule.create
    if @schedule
      render json: { schedule: @schedule }, status: :accepted
    else
      render json: { message: 'could not create' }, status: :not_acceptable
    end
  end
  def destroy
    schedule = Schedule.find(params[:id])
    if schedule
      schedule.destroy
      render json: { schedules: Schedule.all}, status: :accepted
    else
      render json: { message: 'schedule not found' }, status: :not_acceptable
    end
  end
end
