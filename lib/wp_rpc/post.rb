require "wp_rpc/collections/posts"
module WpRpc
  class Post < Base
    attr_accessor :title, :content
    attr_accessor :created_at
    attr_accessor :keywords, :categories, :published
    
    def initialize(attributes = { }, options = { })
      super(options)
      self.attributes = attributes
    end
    
    def attributes=(attr)
      symbolized_attr = { }
      attr = attr.each { |k,v| symbolized_attr[k.to_sym] = v }
      attr = symbolized_attr
      @title = attr[:title]
      @keywords = attr[:keywords].to_s.split(/,|;/).collect { |k| k.strip }
      @categories = attr[:categories]
      @content = attr[:content]
      @created_at = attr[:dateCreated]
      @id = attr[:postid]
      @userid = attr[:userid]
      @published = attr[:published]
    end
    
    def id
      @id
    end
    
    def save
      id ? update : create
    end
    
    def update
      conn.edit_post(id, attributes, published)
      self
    end
    
    def create
      @id = conn.new_post(attributes, published)
      self
    end
    
    def publish
      self.published = true
      save
    end
    
    def keywords
      if @keywords.is_a? String
        @keywords = @keywords.split(",")
      elsif @keywords.is_a? Array
        @keywords
      else
        []
      end
    end
    
    def created_at
      @created_at
    end
    
    def categories
      if @categories.nil?
        []
      elsif @categories.is_a?(Array)
        @categories
      elsif @categories.is_a(String)
        @categories = @categories.split(",")
      else
        []
      end
    end
    
    def attributes
      h = { }
      h[:title] = title if title
      h[:description] = content if content
      h[:dateCreated] = created_at if created_at
      h[:mt_keywords] = keywords.join(",")
      h[:categories] = categories if categories
      h
    end
    
    def reload
      if id
        saved_id = id
        self.attributes = conn.posts.find(id).attributes
        @id = saved_id
        true
      end
    end
  end
end