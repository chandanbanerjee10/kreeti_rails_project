class AddUserIdToTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :types, :user_id, :integer
  end
end
