require 'zip/zip'
require 'zip/zipfilesystem'
require 'ruby_lib/package/base'

module RubyLib
  module Package

    class Zipped < Base

      def initialize(uri)
        super

        @zip = Zip::ZipFile.open(uri)
      end

      protected

      # Retrieves the descriptor from package
      #
      # @return [Hash]
      def _get_descriptor
        _get_file(descriptor_filename)
      end

      # Sets the descriptor to package
      #
      # @param [Hash] descriptor
      def _set_descriptor(descriptor)
        _set_file(descriptor_filename, descriptor)
      end

      # Retrieves the manifest of the package
      #
      # @return [Array<String>] list of files
      def _get_manifest
        @zip.entries.map { |e| e.name }
      end

      # Retrieves the contents of a file from the package
      #
      # @return [String] contents
      def _get_file(name)
        @zip.read(name)
      end

      # Sets the contents of a file from the package
      #
      # @param [String] name
      # @param [String] contents
      def _set_file(name, contents)
        @zip.get_output_stream(name) { |os| os.puts contents }
      end

    end
  end
end