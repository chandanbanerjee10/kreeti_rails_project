class ChangeBooleanToIntegerJobs < ActiveRecord::Migration[7.0]
  def up
    change_column :jobs, :approved_by, :integer
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end

  def down
    change_column :jobs, :approved_by, :boolean
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
