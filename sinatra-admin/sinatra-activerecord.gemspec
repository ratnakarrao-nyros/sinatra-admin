# encoding:utf-8

Gem::Specification.new do |gem|
  gem.name         = 'sinatra-activerecord'
  gem.version      = '1.1.0'

  gem.description  = "Extends Sinatra with ActiveRecord helpers."
  gem.summary      = gem.description
  gem.homepage     = "http://github.com/janko-m/sinatra-activerecord"

  gem.author       = "Janko Marohnić"
  gem.email        = "janko.marohnic@gmail.com"

  gem.license      = "MIT"

  gem.files        = Dir["lib/**/*"] + ["README.md", "LICENSE"]
  gem.require_path = "lib"
  gem.test_files   = gem.files.grep(%r{^(test|spec|features)/})

  gem.required_ruby_version = ">= 1.9.2"

  gem.add_dependency 'sinatra', '~> 1.0'
  gem.add_dependency 'activerecord', '~> 3.0'

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '>= 2.10', '< 3'
end
