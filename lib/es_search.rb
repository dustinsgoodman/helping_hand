class EsSearch

  def initialize(*args)
    opts = args.extract_options!
    @index = opts[:index] if opts[:index]
    @type = opts[:type] if opts[:type]
    @query = opts[:query] || EsSearch::QueryBuilder.build_query {|q| q.match_all }
    @filter = opts[:filter] || {}
    @facets = opts[:facets] || {}
    @model_scope = opts[:model_scope] if opts[:model_scope]
    @ar_options = opts[:ar_options] || {}
  end
    
  def search(*args)
    opts = args.extract_options!
    options = Hash.new.tap {|h|
      h[:size] = opts[:limit] if opts[:limit]
      h[:size] = opts[:per_page] if opts[:per_page]
      h[:from] = ((opts[:page]-1)*opts[:per_page]) if opts[:page] && opts[:per_page]
      h[:sort] = opts[:order] if opts[:order]
      h[:ids_only] = true if opts[:format] == :active_record || opts[:format] == :ids_only
    }
    client = ElasticSearch.new(
      '0.0.0.0:9200', 
      :index => @index, 
      :type => @type
    )
    
    results = client.search(build_search, options)    
    records = nil
    if opts[:format] == :elastic_search
      records = results["hits"]["hits"].collect {|h| h["_source"] }
    elsif opts[:format] == :ids_only
      records = results["hits"]["hits"].collect{|r| r["_id"].to_i}
    else
      ids = results["hits"]["hits"].collect{|r| r["_id"].to_i}
      
      if @model_scope
        records = @model_scope.find(:all, {:conditions => {:id => ids}}.merge(@ar_options))
        if options[:sort]
          records_hash = Hash.new.tap {|h|
            records.each do |r|
              h[r.id] = r
            end
          }
          records = ids.collect{|id| records_hash[id]}.compact
        end
      else
        records = results
      end
    end
    
    Hash.new.tap {|h|
      h[:records] = records
      h[:total_entries] = results["hits"]["total"]
      h[:successful] = results["_shards"]["successful"]
      h[:returned] = results["hits"]["hits"].length
    }
  end
  
  private
  
  def build_search
    {
      :query => {
        :filtered => {
          :query => @query,
          :filter => @filter
        }
      },
      :facets => @facets
    }
  end
  
  class FastJsonEncoder < ElasticSearch::Encoding::Base
    def encode(object)
      JSON.generate(object)
    end

    def decode(string)
      JSON.parse(string)
    end
    
    def is_encoded?(object)
      object.is_a?(String)
    end
  end
end
