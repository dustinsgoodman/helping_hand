class CreateOpportunities < ActiveRecord::Migration
  def up
    create_table :opportunities do |t|
      t.string :name
      t.text :description
      t.boolean :quota
      t.boolean :eligible
      t.integer :owner_id
      t.integer :score
      t.integer :max_ppl
      t.integer :min_ppl
      t.integer :location_id
      t.datetime :event_start
      t.datetime :event_end
    end
  end

  def down
  end
end
