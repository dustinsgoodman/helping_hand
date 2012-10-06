class AddLocationColumnToOpportunities < ActiveRecord::Migration
  def up
    add_column :opportunities, :location, :string
  end

  def down
    remove_column :opportunities, :location
  end
end
