class TaskCustomerSerializer
  include JSONAPI::Serializer

  attributes :id, :task_id, :customer_id, :created_at, :updated_at

  belongs_to :task
  belongs_to :customer
end
