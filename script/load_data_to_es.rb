client = ElasticSearch.new('0.0.0.0:9200', 
  :index=>"opportunities", 
  :type => "opportunity"
)

client.update_mapping({
  :properties => {
    :listing_id => {:type => :integer},
    :address => {:type => :string, :index => :analyzed, :analyzer => :whitespace},
    :city => {:type => :string},
    :state => {:type => :string},
    :county => {:type => :string},
    :neighborhood => {:type => :string},
    :zip_code => {:type => :string},
    :school_elem => {:type => :string},
    :school_middle => {:type => :string},
    :school_high => {:type => :string},
    :property_id => {:type => :integer},
    :status => {:type => :integer},
    :active => {:type => :boolean, :default => :false},
    :closed => {:type => :boolean, :default => :false},
    :publicly_visible => {:type => :boolean},
    :vow_visible => {:type => :boolean},
    :test_listing => {:type => :boolean},
    :foreclosure => {:type => :boolean},
    :short_sale => {:type => :boolean},
    :circumstances => {:type => :short},
    :price => {:type => :integer},
    :close_price => {:type => :integer},
    :original_price => {:type => :integer},
    :year_built => {:type => :integer},
    :bathrooms_full => {:type => :short},
    :bathrooms_half => {:type => :short},
    :bedrooms => {:type => :short},
    :property_type => {:type => :integer},
    :acres_min => {:type => :float},
    :acres_max => {:type => :float},
    :close_date => {:type => :date},
    :geo => {:type => :geo_point, :lat_lon => :true, :geohash => :true},
    :basement => {:type => :string},
    :sq_ft => {:type => :integer}
  }
}, :index => "listings", :type => "stats")

conn = ActiveRecord::Base.connection()

max_id = (conn.select_value %Q{
  SELECT MAX(id) as `max` FROM `listings`
}).to_i
i = 1
while (i <= max_id)
  results = conn.execute %Q{
    SELECT SQL_NO_CACHE 
      `listings`.`id` AS `id` ,
      CONCAT_WS(' ', `properties`.`street_address`, `properties`.`unit`, `properties`.`city`, `properties`.`state`) AS `address`, 
      `properties`.`city` AS `city`, 
      `properties`.`state` AS `state`, 
      `listings`.`county` AS `county`, 
      `listings`.`neighborhood` AS `neighborhood`, 
      `listings`.`zip` AS `zip_code`, 
      `listings`.`school_elem` AS `school_elem`, 
      `listings`.`school_middle` AS `school_middle`, 
      `listings`.`school_high` AS `school_high`, 
      `listings`.`property_id` AS `property_id`, 
      `listings`.`status` AS `status`, 
      (`listings`.`status` < 128) AS `active`, 
      (`listings`.`status` >= 128) AS `closed`, 
      `listings`.`publicly_visible` AS `publicly_visible`, 
      (`listings`.`vow_visible` = 1) OR (`listings`.`publicly_visible` = 1) AS `vow_visible`, 
      `listings`.`test_listing` as `test_listing`,
      `listings`.`foreclosure` AS `foreclosure`, 
      `listings`.`short_sale` AS `short_sale`, 
      IF(`listings`.`foreclosure`, 2, IF(`listings`.`short_sale`, 1, 0)) as `circumstances`,
      `listings`.`price` AS `price`, 
      `listings`.`close_price` AS `close_price`, 
      `listings`.`original_price` AS `original_price`, 
      `listings`.`year_built` AS `year_built`, 
      `listings`.`bathrooms_full` AS `bathrooms_full`, 
      `listings`.`bathrooms_half` AS `bathrooms_half`, 
      `listings`.`bedrooms` AS `bedrooms`,
      `listings`.`property_type` AS `property_type`, 
      `listings`.`acres_min` AS `acres_min`, 
      `listings`.`acres_max` AS `acres_max`,
      UNIX_TIMESTAMP(`listings`.`close_date`) AS `close_date`,
      `properties`.`latitude` AS `latitude`, 
      `properties`.`longitude` AS `longitude`, 
      `listings`.`basement` AS `basement`, 
      `listings`.`sq_ft` AS `sq_ft`
    FROM `listings`
    LEFT OUTER JOIN `properties` 
    ON `properties`.`id` = `listings`.`property_id` 
    LEFT OUTER JOIN `listings` l3
    ON `listings`.`property_id` = l3.`property_id`
    AND l3.`mls_id` != `listings`.`mls_id`
    AND l3.`priority` < `listings`.`priority`
    WHERE `listings`.`property_type` IN (0,1,3,4,7) 
    AND (`listings`.`status` < 128 OR (`listings`.`status` = 128 AND `listings`.`close_date` > "#{1.year.ago.to_s}"))
    AND `listings`.`deleted` = 0 
    AND l3.`id` IS NULL
    AND `listings`.`id` BETWEEN #{i} AND #{i+10000}
  }
  #"
  
  results.each do |id, address, city, state, county, 
    neighborhood, zip_code, school_elem, school_middle, school_high, 
    property_id, status, active, closed, publicly_visible, vow_visible, 
    test_listing, foreclosure, short_sale, circumstances, 
    price, close_price, original_price, year_built, bathrooms_full,
    bathrooms_half, bedrooms, property_type, acres_min,
    acres_max, close_date, latitude, longitude, basement, sq_ft|
   
    client.index({
      :listing_id => id,
      :address => address,
      :city => city,
      :state => state,
      :county => county,
      :neighborhood => neighborhood,
      :zip_code => zip_code,
      :school_elem => school_elem,
      :school_middle => school_middle,
      :school_high => school_high,
      :property_id => property_id,
      :status => status,
      :active => (active == 1) ? true : false,
      :closed => (closed == 1) ? true : false,
      :publicly_visible => (publicly_visible == 1) ? true : false,
      :vow_visible => (vow_visible == 1) ? true : false,
      :test_listing => (test_listing == 1) ? true : false,
      :foreclosure => (foreclosure == 1) ? true : false,
      :short_sale => (short_sale == 1) ? true : false,
      :circumstances => circumstances,
      :price => (price.nil? || price == 0) ? -1 : price,
      :close_price => (close_price.nil? || close_price == 0) ? -1 : close_price,
      :original_price => (original_price.nil? || original_price == 0) ? -1 : original_price,
      :year_built => year_built.nil? ? -1 : year_built,
      :bathrooms_full => bathrooms_full.nil? ? -1 : bathrooms_full,
      :bathrooms_half => bathrooms_half.nil? ? -1 : bathrooms_half,
      :bedrooms => bedrooms.nil? ? -1 : bedrooms,
      :property_type => property_type,
      :acres_min => acres_min.nil? ? -1 : acres_min,
      :acres_max => acres_max.nil? ? -1 : acres_max,
      :close_date => close_date,
      :geo => [longitude, latitude],
      :basement => basement,
      :sq_ft => sq_ft
    }, :id => id)
  end
  
  i += 10000
end