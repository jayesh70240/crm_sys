class TaskCustomer < ApplicationRecord
  belongs_to :task
  belongs_to :customer
end
