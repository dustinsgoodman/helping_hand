class CreateUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :location_id
      t.float :rating
      t.integer :age
    end
  end

  def down
  end
end
