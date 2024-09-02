class TaskSerializer
  include JSONAPI::Serializer

  attributes :id, :user_id, :description, :due_date, :status, :created_at, :updated_at

  belongs_to :user
  has_many :task_customers, serializer: TaskCustomerSerializer
  has_many :customers
  has_many :call_logs
end
