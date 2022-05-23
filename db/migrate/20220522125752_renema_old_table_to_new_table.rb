class RenemaOldTableToNewTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :sectors_types, :sector_types
  end
end
