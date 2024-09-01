class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email

  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%d/%m/%Y')
  end

  attribute :updated_date do |user|
    user.updated_at && user.updated_at.strftime('%d/%m/%Y')
  end
end
