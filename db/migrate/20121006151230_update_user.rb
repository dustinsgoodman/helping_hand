class UpdateUser < ActiveRecord::Migration
  def up
    create_table :users, :force => true do |t|
      t.string    :login,               :null => false, :limit => 20  # optional, you can use email instead, or both
      t.string    :email,               :null => false, :limit => 100 # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
      
      t.string    :first_name,          :null => false
      t.string    :last_name,           :null => false
      t.integer   :location_id
      t.float     :rating,              :null => false, :default => 0
      t.integer   :age,                 :null => false
    end
    
    add_index :users, :login, :unique => true
  end

  def down
    drop_table :users
    
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
end
