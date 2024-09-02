class CallLog < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  belongs_to :task

  enum call_status: [ :successful, :unanswered, :follow_up_required]
end
