class CreateSponsorTable < ActiveRecord::Migration
  def up
    drop_table :sponsors
  end

  def down
  end
end
