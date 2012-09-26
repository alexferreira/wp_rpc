module WpRpc
  class Error < StandardError ; end
  class ConnectionFailure < Error ; end

  class Base
    def initialize(options = { })
      @conn = options[:conn] || options[:connection]
    end
    
    def conn
      @conn
    end

    def pattern
      @pattern = {"post_title" => "title", "post_content" => "content"}
    end

    def change_attributes(source, mappings = {})
      source.map{ |obj| obj.keys.each { |k| obj[mappings[k] ] = obj.delete(k) if mappings[k] } }
      source
    end
  end
end
