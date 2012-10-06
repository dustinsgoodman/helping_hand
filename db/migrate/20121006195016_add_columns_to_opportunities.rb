class AddColumnsToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :keywords, :string
  end
end
