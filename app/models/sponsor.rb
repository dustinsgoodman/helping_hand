class Sponsor < ActiveRecord::Base
  has_and_belongs_to_many :opportunites

  attr_accessible :name, :email, :rating

  validates_presence_of :name

  def self.find_or_create(attrs)
    email = attrs[:email]
    user = nil
    if email
      begin
        connection.execute "LOCK TABLES users WRITE"
        sponsor = find(:first, :conditions => {:email => email})
        unless sponsor
          logger.info "Organization #{email} not found, creating"
           = create(attrs)
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
end
