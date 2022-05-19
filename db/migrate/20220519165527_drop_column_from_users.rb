class DropColumnFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role
    remove_column :users, :role_id
  end
end
