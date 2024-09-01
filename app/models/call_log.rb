class CallLog < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  enum call_status: [ :successful, :unanswered, :follow_up_required]
end
