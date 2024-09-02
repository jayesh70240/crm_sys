class CallLogSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :customer_id, :call_time, :call_status, :remarks, :created_at, :updated_at, :task_id
end
