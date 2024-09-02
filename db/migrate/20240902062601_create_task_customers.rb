class CreateTaskCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :task_customers do |t|
      t.references :task, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
