class AppointmentController < ApplicationController

  def create
    schedule = Schedule.find(params[:id])
    if schedule
      if Integer(app_params[:start_time]) >= Integer(app_params[:end_time])
        render json: { message: 'End time must be greater than the start time.' }, status: :not_acceptable
      else # ------------------------------------------------
        puts "checker:"
        checker = schedule.appointments.all.select do |current|
          if Integer(app_params[:start_time]) <= current.end_time
            if Integer(app_params[:start_time]) >= current.start_time
              true
            end
          end
          if Integer(app_params[:end_time]) <= current.end_time
            if Integer(app_params[:end_time]) >= current.start_time
              true
            end
          end
          if Integer(app_params[:end_time]) == current.start_time || Integer(app_params[:end_time]) == current.end_time
            true
          end
          if Integer(app_params[:start_time]) == current.start_time || Integer(app_params[:start_time]) == current.end_time
            true
          end
        end
        if checker.length > 0
          render json: { message: 'Appointments within a Schedule can not overlap.' }, status: :not_acceptable
        else
          appointment = Appointment.new(app_params)
          appointment.schedule_id = schedule.id
          appointment.save
          render json: { schedule: ScheduleSerializer.new(schedule)}, status: :accepted
        end
      end # ------------------------------------------

    else
      render json: { message: 'could not create, schedule not found' }, status: :not_acceptable
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    if schedule
      appointment = Appointment.find(params[:num])
      if appointment
        appointment.destroy
        render json: { schedules: Schedule.all}, status: :accepted
      else
        render json: { message: 'appointment not found' }, status: :not_acceptable
      end
    else
      render json: { message: 'schedule not found' }, status: :not_acceptable
    end
  end

  private
  def app_params
    params.require(:appointment).permit(:start_time, :end_time)
  end
end
