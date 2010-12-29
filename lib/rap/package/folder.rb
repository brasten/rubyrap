require 'rap/package/base'
require 'rap/errors'

module Rap
  module Package

    # Implements Rap::Package::Base interface for folder raps.
    #
    class Folder < Base

      def initialize(uri)
        super
      end

      def open
        raise NoPackageError    unless File.exists?(uri)
        raise InvalidTypeError  unless File.directory?(uri)

        self
      end

      def create
        FileUtils.mkdir_p(uri)

        self
      end

      def close
        # noop
      end

      protected

      # Retrieves the descriptor from package
      #
      # @return [String]
      def _get_descriptor
        _get_file(descriptor_filename)
      end

      # Sets the descriptor to package
      #
      # @param [String] descriptor
      def _set_descriptor(descriptor)
        _set_file(descriptor_filename, descriptor)
      end

      # Retrieves the manifest of the package
      #
      # @return [Array<String>] list of files
      def _get_manifest
        Dir["#{uri}/**/*"].map { |entry|
          entry = "#{entry}/" if File.directory?(entry)
          entry.sub(uri, "").sub(/^\//, "")
        }
      end

      # Retrieves the contents of a file from the package
      #
      # @return [String] contents
      def _get_file(name)
        File.read("%s/%s" % [uri, name])
      end

      # Sets the contents of a file from the package
      #
      # @param [String] name
      # @param [String] contents
      def _set_file(name, contents)
        File.open("%s/%s" % [uri, name], "w") { |io| io.write contents }
      end

    end
  end
end