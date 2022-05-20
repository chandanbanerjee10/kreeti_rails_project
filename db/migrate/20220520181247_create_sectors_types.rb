class CreateSectorsTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :sectors_types do |t|
      t.integer :sector_id
      t.integer :type_id
      t.timestamps
    end
  end
end
