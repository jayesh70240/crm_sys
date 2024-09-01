class Task < ApplicationRecord
  belongs_to :user

  enum status: [:pending, :in_progress, :completed]
end
