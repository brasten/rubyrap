require 'rubygems/format'

module RubyLib
  class Package

    def initialize(gem_path)
      @format = ::Gem::Format.from_file_by_path(gem_path)
    end

    def spec
      @format.spec
    end
    
    def files
      @format.file_entries.map { |f| f.first['path'] }
    end
    
    def body_for(file)
      @format.file_entries.find { |f| f.first['path'] == file }.last
    end
    
    def path
      @format.gem_path
    end
    
  end
end