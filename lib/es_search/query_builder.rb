class EsSearch::QueryBuilder
  
  def self.build_query(&block)
    builder = new
    query = block.call(builder)
  end

  def match_all
    {:match_all => {}}
  end

  def text(key,value,type=nil)
    {:text => { key => {:query => value, :type => type}}}
  end
  
  def term(key,value)
    {:term => {key => value}}
  end

  def bool(type, *filters)
    {:bool => {type => filters}}
  end

end