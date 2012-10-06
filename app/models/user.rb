class User < ActiveRecord::Base
  has_and_belongs_to_many :opportunites

  attr_accessible :first_name, :last_name, :email, :password
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  def name
    [first_name, last_name].join(" ")
  end
  
  
end
