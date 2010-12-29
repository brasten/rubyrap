$:.unshift('lib')
require 'rap/version'

Gem::Specification.new do |s|
  s.name        = "rubyrap"
  s.version     = Rap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brasten Sager"]
  s.email       = ["brasten@nagilum.com"]
  s.homepage    = "http://github.com/brasten/rubyrap"
  s.summary     = "The best way to manage your application's dependencies"
  s.description = "RubyRap does something."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec"

  s.files        = Dir.glob("{bin,lib}/**/*")
  s.executables  = ['rap']
  s.require_path = 'lib'
end
