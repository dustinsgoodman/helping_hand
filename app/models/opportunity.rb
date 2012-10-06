class Opportunity < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  attr_accessible :name, :description, :max_ppl, :min_ppl, :event_start, :event_end, :location_id, :owner_id, :num_ppl, :location
end
