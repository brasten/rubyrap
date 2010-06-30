require 'rubygems/format'

module Carat
  class Package

    def initialize(gem_path)
      @format = ::Gem::Format.from_file_by_path(@path)
    end

    def spec
      @format.spec
    end
    
    def entries
      @format.file_entries
    end
    
    def path
      @format.gem_path
    end
    
  end
end