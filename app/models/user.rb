class User < ActiveRecord::Base
  has_and_belongs_to_many :opportunites
  #TODO: write location relation

  attr_accessible :first_name, :last_name, :email, :password, 
    :location, :rating, :age
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  
  def self.find_or_create(attrs)
    email = attrs[:email]
    user = nil
    if email
      begin
        connection.execute "LOCK TABLES users WRITE"
        user = find(:first, :conditions => {:email => email})
        unless user
          logger.info "User #{email} not found, creating"
          user = create(attrs)
        end
      ensure
        connection.execute "UNLOCK TABLES"
      end
      user
    else
      logger.error "Must specify email when creating user"
      nil
    end
  end
  
  def name
    [first_name, last_name].join(" ")
  end
  
end
