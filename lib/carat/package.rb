require 'carat/package/gem'

module Carat
  module Package
    
    def self.for(filename)
      if filename ~= /\.gem$/
        ::Carat::Package::Gem.new(filename)
      end
    end
    
  end
end