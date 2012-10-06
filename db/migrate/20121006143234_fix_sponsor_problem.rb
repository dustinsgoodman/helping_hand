class FixSponsorProblem < ActiveRecord::Migration
  def up
    create_table :sponsors do |t|
      t.string :name
      t.string :website
      t.string :crypted_password, :null => false
      t.string :password,         :null => false
      t.string :email,   :limit => 100, :null => false
      t.decimal :rating, :precision => 2, :scale => 1
    end
  end

  def down
  end
end
