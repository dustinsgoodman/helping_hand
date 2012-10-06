class Location < ActiveRecord::Base
  belongs_to :opportunity
  has_and_belongs_to_many :users

  attr_accessible :name
end
