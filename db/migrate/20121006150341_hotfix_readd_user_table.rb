class HotfixReaddUserTable < ActiveRecord::Migration
  def up
    create_table :users, :force => true do |t|
      t.string  :login,             :null => false, :limit => 20
      t.string  :first_name,        :null => false
      t.string  :last_name,         :null => false
      t.string  :email,             :null => false, :limit => 100
      t.string  :crypted_password,  :null => false
      t.string  :password_salt,     :null => false
      t.integer :location_id
      t.float   :rating,            :null => false, :default => 0
      t.integer :age,               :null => false
    end

    add_index :users, :login, :unique => true
  end

  def down
  end
end
