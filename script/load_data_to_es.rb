client = ElasticSearch.new('0.0.0.0:9200', 
  :index=>"opportunities", 
  :type => "opportunity"
)

client.update_mapping({
  :properties => {
    :id => {:type => :integer},
    :name => {:type => :string},
    :description => {:type => :string},
    :keywords => {:type => :string},
    :owner => {:type => :string},
    :score => {:type => :integer},
    :max_ppl => {:type => :integer},
    :min_ppl => {:type => :integer},
    :num_ppl => {:type => :integer},
    :min_age => {:type => :intger},
    :max_age => {:type => :intger},
    :location_id => {:type => :integer},
    :location => {:type => :string},
    :event_start => {:type => :date},
    :event_end => {:type => :date}
  }, 
}, :index => "opportunities", :type => "opportunity")

conn = ActiveRecord::Base.connection()

max_id = (conn.select_value %Q{
  SELECT MAX(id) as `max` FROM `listings`
}).to_i
i = 1
while (i <= max_id)
  results = conn.execute %Q{
    SELECT SQL_NO_CACHE 
      o.id AS id,
      o.name AS name,
      o.description AS description,
      o.keywords AS keywords,
      o.owner AS owner,
      o.score AS score,
      o.max_ppl AS max_ppl,
      o.min_ppl AS min_ppl,
      o.num_ppl AS num_ppl,
      o.min_age AS min_age,
      o.max_age AS max_age,
      o.location_id AS location_id,
      CONCAT_WS(' ', l.name, l.county, l.city, l.state, l.addr, l.zip) AS location,
      UNIX_TIMESTAMP(o.event_start) AS event_start,
      UNIX_TIMESTAMP(o.event_end) AS event_end
    FROM opportunities o
    LEFT OUTER JOIN locations l
    ON o.location_id = l.id
    AND o.id BETWEEN #{i} AND #{i+10000}
  }
  
  results.each do |id, name, description, keywords, owner, score,
    max_ppl, min_ppl, num_ppl, min_age, max_age, location_id,
    location, event_start, event_end|
   
    client.index({
      :id => id,
      :name => name,
      :description => description,
      :keywords => keywords,
      :owner => owner, 
      :score => score,
      :max_ppl => max_ppl,
      :min_ppl => min_ppl,
      :num_ppl => num_ppl,
      :min_age => min_age,
      :max_age => max_age,
      :location_id => location_id,
      :location => location,
      :event_start => event_start,
      :event_end => event_end
    }, :id => id)
  end
  
  i += 10000
end