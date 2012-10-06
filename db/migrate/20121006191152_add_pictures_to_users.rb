class AddPicturesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :picture_id, :string
    add_column :sponsors, :picture_id, :string
  end
end
