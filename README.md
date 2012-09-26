# WpRpc

WpRpc is a Ruby library for reading and writing blogs to Wordpress via XMLRPC interface.

The documentation is missing and the test set is not complete.

## Installation

Add this line to your application's Gemfile:

    gem 'wp_rpc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wp_rpc

### Usage

	require 'wp_rpc'
	blog = WpRpc::Blog.new :url => 'http://www.example.com/xmlrpc.php', :username => 'admin', :password=> 'admin'

	# Output the list of categories
	blog.categories.map { |c| puts "Category: #{c.name}" }
	
	# Get List of Posts
	blog.posts.all.map{|p| puts p['title']}

	# Get the 20 most recent posts
	blog.posts.find_recent(:limit => 20).map { |p| puts "#{p.id} | #{p.title}" }

	# Create a new blog post
	post = blog.posts.new(:title => 'Test', :description => 'This is a test', :keywords => 'test, testing', :published => true)
	post.save

	# Edit a blog post
	post = blog.posts.find(1)
	post.title = "Edited title"
	post.save

	# Upload an attachment
	attachment = blog.attachments.new(:name => 'Photo of me', :filename => '/home/john/me.jpg')
	attachment.save

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
