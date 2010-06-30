module Carat
  class Definition

    attr_accessor :name
    attr_accessor :version
    attr_accessor :platform
    attr_accessor :authors
    attr_accessor :email
    attr_accessor :homepage
    attr_accessor :summary
    attr_accessor :description
    attr_accessor :bindir
    attr_accessor :files
    attr_accessor :executables
    attr_accessor :require_path

    
    class << self
      
      def load(filename)
        definition = nil
        @@collector = proc { |df| definition = df }
        definition
      ensure
        @@collector = nil
      end
      
    end



    def initialize(&block)
      if block.arity == 0
        instance_eval(&block)
      else
        block.call(self)
      end
      
      @@collector.call(self) if @@collector
    end
    
  end
end

# Gem::Specification.new do |s|
#   s.name        = "ems-auth"
#   s.version     = Ems::Auth::VERSION
#   s.platform    = Gem::Platform::RUBY
#   s.authors     = ["Garrett Conaty", "Paul Brown", "Brasten Sager"]
#   s.email       = ["garrett@conaty.net", "prb@mult.ifario.us", "brasten@nagilum.com"]
#   s.homepage    = ""
#   s.summary     = "Authentication module for Ems"
#   s.description = "Authentication module"
#  
#   s.required_rubygems_version = ">= 1.3.6"
#   s.rubyforge_project         = "bundler"
#  
#   s.add_development_dependency "rspec"
#  
#   s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md ROADMAP.md CHANGELOG.md)
#   s.executables  = ['bundle']
#   s.require_path = 'lib'
# end