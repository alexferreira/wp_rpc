module WpRpc
  module Collection
    class Posts < Base
      def find_recent(options = { })
        options = { :limit => 10 }.merge(options)
        posts = conn.get_recent_posts(options[:limit])
        posts.collect { |post|  Post.new(post, :conn => conn) }
      end
      
      def find(qid, options = { })
        if qid.is_a?(Array)
          qid.collect { |sqid| find(sqid) }
        elsif qid == :recent
          find_recent(options)
        else
          post = conn.get_post(qid)
          Post.new(post, :conn => conn)
        end
      end
      
      def new(attributes = { })
        WpRpc::Post.new(attributes, :conn => conn)
      end

      def all
        change_attributes(conn.call('wp.getPosts', conn.blog_id, conn.username, conn.password), pattern)
      end

      def delete(ids)
        posts = {}
        if ids.is_a?(Array)
          ids.each do |id|
            posts = posts.merge({id => conn.call('wp.deletePost', conn.blog_id, conn.username, conn.password, id) })
          end 
          posts
        else 
          conn.call('wp.deletePost', conn.blog_id, conn.username, conn.password, id)
        end
      end

      def status
        conn.call('wp.getPostStatusList', conn.blog_id, conn.username, conn.password)
      end

      def formats
        conn.call('wp.getPostFormats', conn.blog_id, conn.username, conn.password)
      end

      def types
        conn.call('wp.getPostTypes', conn.blog_id, conn.username, conn.password)
      end

      def type(name)
        conn.call('wp.getPostType', conn.blog_id, conn.username, conn.password, name)
      end
    end  
  end
end