ROOT_PATH = File.join(File.dirname(__FILE__), '..')
$:.unshift ROOT_PATH unless $:.include? ROOT_PATH

require 'rubygems'
require 'lib/wp_rpc.rb'
include WpRpc

def valid_wp_blog_options
  { :username => 'lily', :password => 'lilybeans', :url => 'http://example.com', :blog_id => 666 }
end
  
def valid_wp_post_options
  { :title => "Test Post", :description => "The text of the post", :dateCreated => Time.at(1284243726),
    :mt_keywords => 'test,post,example', :categories => 'blog' }
end

def a_wp_blog
  Blog.new(valid_wp_blog_options)
end

def valid_wp_upload_options
  { :name => "A file", :type => "application/octet-stream",
    :bits => "12345678910", :overwrite => false }
end

def valid_category_options
  { :name => 'Posts', :slug => 'posts', :parent_id => nil, :description => "Blog posts" }
end
