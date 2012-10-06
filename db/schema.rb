# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121006150341) do

  create_table "sponsors", :force => true do |t|
    t.string  "name"
    t.string  "website"
    t.string  "crypted_password",                                              :null => false
    t.string  "password",                                                      :null => false
    t.string  "email",            :limit => 100,                               :null => false
    t.decimal "rating",                          :precision => 2, :scale => 1
  end

  create_table "users", :force => true do |t|
    t.string  "login",            :limit => 20,                   :null => false
    t.string  "first_name",                                       :null => false
    t.string  "last_name",                                        :null => false
    t.string  "email",            :limit => 100,                  :null => false
    t.string  "crypted_password",                                 :null => false
    t.string  "password_salt",                                    :null => false
    t.integer "location_id"
    t.float   "rating",                          :default => 0.0, :null => false
    t.integer "age",                                              :null => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
