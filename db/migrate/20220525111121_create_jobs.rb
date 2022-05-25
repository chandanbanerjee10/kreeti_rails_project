class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :job_description
      t.string :job_location
      t.string :keyskills
      t.integer :sector_id
      t.integer :type_id
      t.integer :user_id
      t.timestamps
    end
  end
end
