class DropSectorType < ActiveRecord::Migration[7.0]
  def change
    drop_table :sector_types
  end
end
