class CreateLocationTable < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.string :name
      t.string :county
      t.string :city
      t.string :state
      t.string :addr
      t.float  :long
      t.float  :lat
      t.integer :zip
    end
  end

  def down
  end
end
