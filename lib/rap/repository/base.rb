require 'ostruct'

module Rap
  module Repository

    # Base interface for Rap repositories
    #
    class Base
   
      attr_reader :context
   
      class << self
        def default_context
          puts "default"
          OpenStruct.new(:base_uri => '')
        end
      end
   
      def initialize(options={})
        if options[:context].nil?
          raise StandardError
        end
        @context = options[:context] || self.class.default_context
      end
   
      def get( uri )
        raise NotImplementedError
      end

      def put( uri, content_io )
        raise NotImplementedError
      end

      def create_directory( uri )
        raise NotImplementedError
      end
      
      def remove_directory( uri )
        raise NotImplementedError
      end

      def list( uri=nil )
        raise NotImplementedError
      end

      def exists?( uri )
        raise NotImplementedError
      end
      
    end
  end
end