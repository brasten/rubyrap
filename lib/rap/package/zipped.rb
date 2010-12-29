require 'rap/vendor/zip/zip'
require 'rap/vendor/zip/zipfilesystem'
require 'rap/package/base'

module Rap
  module Package

    # Implements Rap::Package::Base interface for zipped raps.
    #
    class Zipped < Base

      def initialize(uri)
        super
      end

      def open
        @zip = Zip::ZipFile.open(uri)

        self
      end

      def create
        @zip = Zip::ZipFile.open(uri, Zip::ZipFile::CREATE)

        self
      end

      def close
        @zip.commit if @zip.commit_required?
        @zip.close
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