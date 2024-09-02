class Customer < ApplicationRecord
  has_many :task_customers, dependent: :destroy
  has_many :tasks, through: :task_customers
  has_many :call_logs, dependent: :destroy

  validates :name, :phone_number, presence: true
end
