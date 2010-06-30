require 'zip/zipfilesystem'
require 'carat/definition'

module Carat
  module Package
    class Base
      
      attr_reader :name
      
      def initialize(name)
        @name = name
      end

      def definition
        raise NotImplementedYet
      end
      
    end
    
  end
end