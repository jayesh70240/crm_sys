class AddTaskIdToCallLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :call_logs, :task_id, :integer
  end
end
