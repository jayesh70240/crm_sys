class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
  	add_column :users, :phone_number, :string
    add_column :users, :role, :integer
    add_column :users, :status, :boolean
  end
end
