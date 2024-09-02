class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :role, :status

  has_many :tasks
  has_many :call_logs
  
  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%d/%m/%Y')
  end

  attribute :updated_date do |user|
    user.updated_at && user.updated_at.strftime('%d/%m/%Y')
  end
end
