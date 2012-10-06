class RemoveLocationIdColumnFromOpportunities < ActiveRecord::Migration
  def up
    remove_column :opportunities, :location_id
  end

  def down
    add_column :opportunities, :location_id, :integer
  end
end
