class Opportunity < ActiveRecord::Base
  has_and_belongs_to_many :users
<<<<<<< HEAD

  attr_accessible :name, :description, :max_ppl, :min_ppl, :event_start, :event_end, :location_id, :owner_id, :num_ppl
=======
  
  attr_accessible :name, :description, :max_ppl, :min_ppl, :event_start, :event_end, :location_id, :owner_id, :num_ppl, :location
>>>>>>> a624ed56db8c99a834bcdb94a24d2cd183b23fec
end
