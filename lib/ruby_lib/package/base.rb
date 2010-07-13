require 'yaml'

module RubyLib
  module Package

    # Abstract base class for packages
    #
    class Base
      attr_reader   :uri

      def initialize(uri)
        @uri  = uri
      end

      def manifest
        @manifest ||= _get_manifest
      end

      protected

      def descriptor=(desc)
        self._set_descriptor(YAML.dump(desc.to_hash))

        @descriptor = desc
      end

      def descriptor
        @descriptor ||= RubyLib::Descriptor.from_hash(
          YAML.load(self._get_descriptor)
        )
      end


      ##
      # Interface to implement in subclasses
      ##

      # Retrieves the descriptor from package
      #
      # @return [Hash]
      def _get_descriptor
        raise NotImplementedError
      end

      # Sets the descriptor to package
      #
      # @param [Hash] descriptor
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
