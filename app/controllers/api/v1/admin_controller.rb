class Api::V1::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: [:show_telecaller, :update_telecaller, :destroy_telecaller]
  before_action :set_call_log, only: [:update_call_log, :destroy_call_log]
  before_action :set_customer, only: [:update_customer, :show_customer, :destroy_customer]
  before_action :set_task, only: [:update_task, :destroy_task]

  # Telecallers Management

  #GET /api/v1/admin/telecallers
  def telecallers
    users = User.employee
    render_success(message: 'Telecallers retrieved successfully', data: users)
  end

  #GET /api/v1/admin/:id/show_telecaller
  def show_telecaller
    render_success(message: 'Telecaller retrieved successfully', data: @user)
  end

  #POST /api/v1/admin/create_telecaller
  def create_telecaller
    user = User.new(user_params)
    if user.save
    	if user.role == "admin"
      		render_success(message: 'Admin created successfully', data: user, status: :created)
      	else
      		render_success(message: 'Telecaller created successfully', data: user, status: :created)
      	end
    else
      render_error(message: 'Failed to create user', errors: user.errors.full_messages)
    end
  end

  #PATCH /api/v1/admin/:id/update_telecaller
  def update_telecaller
    if @user.update(user_params)
      render_success(message: 'Telecaller updated successfully', data: @user)
    else
      render_error(message: 'Failed to update telecaller', errors: @user.errors.full_messages)
    end
  end

 #DELETE /api/v1/admin/:id/destroy_telecaller
  def destroy_telecaller
    if @user.destroy
      render_success(message: 'Telecaller deleted successfully', status: :ok)
    else
      render_error(message: 'Failed to delete telecaller')
    end
  end

  # Call Logs Management

 #GET /api/v1/admin/call_logs 
  def call_logs
    call_logs = CallLog.all
    render_success(message: 'Call logs retrieved successfully', data: call_logs)
  end

 #POST /api/v1/admin/call_logs
  def assign_call_log
    call_log = CallLog.new(call_log_params)
    if call_log.save
      render_success(message: 'Call log created successfully', data: call_log, status: :created)
    else
      render_error(message: 'Failed to create call log', errors: call_log.errors.full_messages)
    end
  end

 #PATCH /api/v1/admin/:id/update_call_log
  def update_call_log
    if @call_log.update(call_log_params)
      render_success(message: 'Call log updated successfully', data: @call_log)
    else
      render_error(message: 'Failed to update call log', errors: @call_log.errors.full_messages)
    end
  end
 #DELETE /api/v1/admin/:id/destroy_call_log
  def destroy_call_log
    if @call_log.destroy
      render_success(message: 'Call log deleted successfully', status: :ok)
    else
      render_error(message: 'Failed to delete call log')
    end
  end

# Task Management
 
 #GET /api/v1/admin/tasks
  def tasks
    tasks = Task.all
    render_success(message: 'Tasks retrieved successfully', data: tasks)
  end

 #POST /api/v1/admin/create_task
  def create_task
    task = Task.new(task_params)
    if task.save
      render_success(message: 'Task created successfully', data: task, status: :created)
    else
      render_error(message: 'Failed to create task', errors: task.errors.full_messages)
    end
  end

 #PATCH /api/v1/admin/:id/update_task
  def update_task
    if @task.update(task_params)
      render_success(message: 'Task updated successfully', data: @task)
    else
      render_error(message: 'Failed to update task', errors: @task.errors.full_messages)
    end
  end

 #DELETE /api/v1/admin/:id/destroy_task
  def destroy_task
    if @task.destroy
      render_success(message: 'Task deleted successfully', status: :ok)
    else
      render_error(message: 'Failed to delete task')
    end
  end

  #POST /api/v1/admin/:id/assign_customers_to_task
  # def assign_customers_to_task
  #   task = Task.find(params[:id])
  #   customers = Customer.where(id: params[:customer_ids])
  #   task.customers << customers

  #   if task.save
  #     render_success(message: 'Customers assigned to task', data: {task: task,
  #       customers: task.customers})
  #   else
  #     render_error(message: 'Failed to assign customers', errors: task.errors.full_messages)
  #   end
  # end

  def assign_customers_to_task
	task = Task.find(params[:id])
	already_assigned_customers = task.customers.pluck(:id)
	new_customer_ids = params[:customer_ids] - already_assigned_customers
	new_customers = Customer.where(id: new_customer_ids)

	if new_customers.present?
		task.customers << new_customers
	end

	if task.save
	message = new_customers.present? ? 'Customers assigned to task' : 'Customers already assigned'

	render_success(
		message: message,
		data: {
		task: task,
		customers: tasks.customers,
		}
	)
	else
	render_error(message: 'Failed to assign customers', errors: task.errors.full_messages)
	end
end


  #PATCH /api/v1/admin/:id/mark_task_complete
  def mark_task_complete
    task = Task.find(params[:id])
    if task.update(status: 'completed')
      render_success(message: 'Task marked as complete', data: task)
    else
      render_error(message: 'Failed to mark task as complete', errors: task.errors.full_messages)
    end
  end

  # Customer Management

  #GET /api/v1/admin/customers
  def customers
    cstmrs = Customer.all
    render_success(message: 'Customer retrieved successfully', data: cstmrs)
  end

  #GET /api/v1/admin/:id/customer
  def show_customer
    render_success(message: 'Customer retrieved successfully', data: @cstmr)
  end

  #POST /api/v1/admin/create_customer
  def create_customer
    cstmr = Customer.new(customer_params)
    if cstmr.save
      render_success(message: 'Customer created successfully', data: cstmr, status: :created)
    else
      render_error(message: 'Failed to create customer', errors: cstmr.errors.full_messages)
    end
  end

  #PATCH /api/v1/admin/:id/update_customer
  def update_customer
    if @cstmr.update(customer_params)
      render_success(message: 'Customer updated successfully', data: @cstmr)
    else
      render_error(message: 'Failed to update customer', errors: @cstmr.errors.full_messages)
    end
  end

  #DELETE /api/v1/admin/:id/destroy_customer
  def destroy_customer
    if @cstmr.destroy
      render_success(message: 'Customer deleted successfully', status: :ok)
    else
      render_error(message: 'Failed to delete customer')
    end
  end

  private

  def authorize_admin
    render_error(message: 'Access denied', status: :forbidden) unless current_user.admin?
  end

  def set_user
    @user = User.where(role: :employee).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_error(message: 'User not found', status: :not_found)
  end

  def set_call_log
    @call_log = CallLog.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_error(message: 'Call log not found', status: :not_found)
  end

  def set_customer
    @cstmr = Customer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_error(message: 'Customer not found', status: :not_found)
  end

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_error(message: 'Task not found', status: :not_found)
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation, :role)
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone_number, :address, :notes)
  end

  def call_log_params
    params.require(:call_log).permit(:user_id, :customer_id, :call_time, :call_status, :remarks, :task_id)
  end

  def task_params
    params.require(:task).permit(:user_id, :description, :due_date, :status)
  end

  def render_success(message: 'Success', data: {}, status: :ok)
    render json: { message: message, data: data, status: status, success: true }, status: status
  end

  def render_error(message: 'Error', errors: [], status: :unprocessable_entity)
    render json: { message: message, errors: errors, status: status, success: false }, status: status
  end
end
