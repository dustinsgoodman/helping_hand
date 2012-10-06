class AddOpportunityIdTolocations < ActiveRecord::Migration
  def up
    add_column :locations, :opportunity_id, :integer
  end

  def down
    remove_column :locations, :opportunity_id
  end
end
