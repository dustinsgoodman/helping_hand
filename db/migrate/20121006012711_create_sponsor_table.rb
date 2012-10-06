class CreateSponsorTable < ActiveRecord::Migration
  def up
    create_table :sponsors do |t|
      t.string :name
      t.string :website
      t.decimal :rating, :precision => 2, :scale => 1
    end
  end

  def down
  end
end
