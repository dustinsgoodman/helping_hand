class CreateOpportunities < ActiveRecord::Migration
  def up
    create_table :opportunities do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :owner_id, :null => false
      t.integer :score
      t.integer :max_ppl
      t.integer :min_ppl, :null => false
      t.integer :num_ppl, :null => false, :default => 0
      t.integer :min_age
      t.integer :max_age
      t.integer :location_id, :null => false
      t.datetime :event_start, :null => false
      t.datetime :event_end, :null => false
    end
  end

  def down
    drop_table :opportunities
  end
end
