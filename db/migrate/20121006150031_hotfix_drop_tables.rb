class HotfixDropTables < ActiveRecord::Migration
  def up
    drop_table :sponsors
    drop_table :users
    drop_table :locations
    drop_table :opportunities
  end

  def down
  end
end
