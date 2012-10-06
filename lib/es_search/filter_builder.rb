class EsSearch::FilterBuilder
  
  def self.build_filter(&block)
    builder = new
    filter = block.call(builder)
  end
  
  def and(*filters)
    {:and => filters}
  end
  
  def or(*filters)
    {:or => filters}
  end
  
  def not(filter)
    {:not => filter}
  end
  
  def range(key,from, to)
    {:range => {key => {:from => from, :to => to}}}
  end
  
  def term(key,value)
    {:term => {key => value}}
  end
  
end