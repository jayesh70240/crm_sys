class Task < ApplicationRecord
  belongs_to :user
  after_initialize :set_defaults, if: :new_record?

  enum status: [:pending, :in_progress, :completed]

  has_many :task_customers, dependent: :destroy
  has_many :customers, through: :task_customers
  has_many :call_logs, dependent: :destroy

  private
  def set_defaults
  	self.status = :pending if self.status.nil?
  end
end
