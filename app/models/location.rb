class Location < ActiveRecord::Base
  has_and_belongs_to_many :opportunites
  has_and_belongs_to_many :users


end