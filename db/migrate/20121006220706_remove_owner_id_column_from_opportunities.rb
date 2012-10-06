class RemoveOwnerIdColumnFromOpportunities < ActiveRecord::Migration
  def up
    remove_column :opportunities, :owner_id
  end

  def down
    add_column :opportunities, :owner_id, :integer
  end
end
