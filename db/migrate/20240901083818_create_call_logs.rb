class CreateCallLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :call_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.datetime :call_time
      t.integer :call_status
      t.text :remarks

      t.timestamps
    end
  end
end
