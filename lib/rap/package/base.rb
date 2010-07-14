require 'yaml'

module Rap
  module Package

    # Abstract base class for packages
    #
    class Base

      class << self
        def open(uri)
          new(uri).open
        end

        def create(uri)
          new(uri).create
        end
      end

      attr_reader   :uri

      def initialize(uri)
        @uri  = uri
      end

      def name; descriptor.name; end
      def title; descriptor.title; end
      def version; descriptor.version; end
      def description; descriptor.description; end
      def homepage; descriptor.homepage; end

      def set_file(filename, contents=nil)
        _set_file(filename, contents)
      end

      def get_file(filename)
        _get_file(filename)
      end

      def manifest
        @manifest ||= _get_manifest
      end

      def descriptor_filename
        File.basename(uri).split('-').first + ".descriptor"
      end

      def open
        raise NotImplementedError
      end

      def create
        raise NotImplementedError
      end

      def close
        raise NotImplementedError
      end

      protected

      def descriptor=(desc)
        self._set_descriptor(YAML.dump(desc.to_hash))

        @descriptor = desc
      end

      def descriptor
        @descriptor ||= Rap::Descriptor.from_hash(
          YAML.load(self._get_descriptor)
        )
      end


      ##
      # Interface to implement in subclasses
      ##

      # Retrieves the descriptor from package
      #
      # @return [String]
      def _get_descriptor
        raise NotImplementedError
      end

      # Sets the descriptor to package
      #
      # @param [String] descriptor
      def _set_descriptor(descriptor)
        raise NotImplementedError
      end

      # Retrieves the manifest of the package
      #
      # @return [Array<String>] list of files
      def _get_manifest
        raise NotImplementedError
      end

      # Retrieves the contents of a file from the package
      #
      # @return [String] contents
      def _get_file(name)
        raise NotImplementedError
      end

      # Sets the contents of a file from the package
      #
      # @param [String] name
      # @param [String] contents
      def _set_file(name, contents)
        raise NotImplementedError
      end


    end
  end
end
