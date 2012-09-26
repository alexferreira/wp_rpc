require "wp_rpc/collections/attachments"
module WpRpc  
  class Attachment < Base
    attr_accessor :name, :mimetype, :file, :filename, :url
    
    def initialize(attributes, options = { })
      super(options)
      self.name = attributes[:name]
      self.filename = attributes[:filename]
      self.mimetype = attributes[:mimetype]
      self.file = attributes[:file]
    end
    
    def save
      ret = conn.upload_file(name, mimetype, bits)
      self.url = ret["url"]
      self
    end
    
    def mimetype
      @mimetype ||= MIME::Types.type_for(name).to_s
    end
    
    def name
      @name ||= File.basename(filename)
    end
    
    private
    
    def bits
      file.read
    end
    
    def file
      @file ||= File.open(filename)
    end
  end
end