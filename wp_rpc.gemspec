# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wp_rpc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Ferreira"]
  gem.email         = ["alex@dsol.com.br"]
  gem.description   = "A Ruby library to interact with the Wordpress XMLRPC interface"
  gem.summary       = "A Ruby library to interact with the Wordpress XMLRPC interface"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wp_rpc"
  gem.require_paths = ["lib"]

  gem.version       = WpRpc::VERSION
end
