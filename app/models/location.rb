class Location < ActiveRecord::Base
  has_and_belongs_to_many :users


  attr_accessible :name
  def self.find_or_create(attrs)
    city = attrs[:city]


    if location
      begin
        connection.execute "LOCK TABLES users WRITE"
        location = location = Location.find(attrs[:name])
        unless location
          logger.info "location #{email} not found, creating"
          location = create(attrs)
        end
      ensure
        connection.execute "UNLOCK TABLES"
      end
      location
    else
      logger.error "Must specify email when creating user"
      nil
    end
  end
end
