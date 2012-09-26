module WpRpc
  class Blog
    attr_accessor :url, :username, :password, :blog_id

    def initialize(options = { })
      @username = options[:username] if options[:username]
      @password = options[:password] if options[:password]
      @blog_id = options[:blog_id] || 1
      @url = options[:url] if options[:url]
    end
    
    def posts
      @post_collection ||= Collection::Posts.new(:conn => self)
    end
    
    def attachments
      @attachments ||= Collection::Attachments.new(:conn => self)
    end

    def categories
      @categories ||= Collection::Categories.new(:conn => self)
    end

    def get_recent_posts(limit = 10)
      call('metaWeblog.getRecentPosts', blog_id, username, password, limit)
    end

    def get_post(qid)
      call('metaWeblog.getPost', qid, username, password)
    end
    
    def edit_post(qid, attributes, published = nil)
      cargs = ['metaWeblog.editPost', qid, username, password, attributes]
      cargs << published unless published.nil?
      call(*cargs)
    end
    
    def new_post(attributes, published = nil)
      cargs = ['metaWeblog.newPost', blog_id, username, password, attributes]
      cargs << published unless published.nil?
      call(*cargs)
    end
    
    def upload_file(name, mimetype, bits, overwrite = false)

      call('wp.uploadFile', blog_id, username, password, 
           { :name => name, :type => mimetype, :bits => XMLRPC::Base64.new(bits), :overwrite => overwrite })
    end
    
    def call(*args)
      xmlrpc.call(*args)
    rescue XMLRPC::FaultException => e
      if e.message =~ /XML-RPC services are disabled/
        raise WpRpc::ConnectionFailure, e.message
      else
        raise WpRpc::Error, e.message
      end
    end
    
    def xmlrpc
      @xclient ||= XMLRPC::Client.new2(url)
    end
    
  end
end