class Api::V1::TelecallerController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_telecaller

 #GET  
  def assigned_tasks
	tasks = current_user.tasks.includes(:customers, :task_customers, :call_logs)
	render_success(message: 'Assigned tasks', data: TaskSerializer.new(tasks).serializable_hash)
  end


  def log_call
    call_log = CallLog.new(call_log_params.merge(user_id: current_user.id))
    if call_log.save
      render_success(message: 'Call log created', data: call_log, status: :created)
    else
      render_error(message: 'Failed to log call', errors: call_log.errors.full_messages)
    end
  end

  def mark_task_complete
    task = current_user.tasks.find(params[:id])
    if task.update(status: 'completed')
      render_success(message: 'Task marked as complete', data: task)
    else
      render_error(message: 'Failed to mark task as complete', errors: task.errors.full_messages)
    end
  end

  private

  def authorize_telecaller
    render_error(message: 'Access denied! You are not authorized as a Telecaller.', status: :forbidden) unless current_user.employee?
  end

  def call_log_params
    params.require(:call_log).permit(:customer_id, :task_id, :call_time, :call_status, :remarks)
  end

  def render_success(message: 'Success', data: {}, status: :ok)
    render json: { message: message, data: data, status: status, success: true }, status: status
  end

  def render_error(message: 'Error', errors: [], status: :unprocessable_entity)
    render json: { message: message, errors: errors, status: status, success: false }, status: status
  end
end
