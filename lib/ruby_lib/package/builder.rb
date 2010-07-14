require 'ruby_lib/descriptor'
require 'ruby_lib/package'

module RubyLib
  module Package

    # Builder is responsible for constructing a package
    #
    class Builder

      # Library descriptor
      attr_reader :descriptor

      # Source URI (probably a directory) from which to base
      # relative paths in the descriptor
      attr_reader :source_uri


      # Creates a new builder
      #
      # @param [Descriptor] descriptor
      # @param [String] source_uri
      def initialize(descriptor, source_uri)
        @descriptor = descriptor
        @source_uri = clean_path(source_uri)
      end

      #
      def package!
        package = Package.create("%s/%s" % [source_uri, descriptor.default_package_name])

        begin
          descriptor.build.lib.each do |lib_dir|
            Dir[ ("%s/%s/**/*" % [source_uri, lib_dir]) ].each do |lib_file|
              file_id     = lib_file.gsub(Regexp.new("^#{source_uri}/#{lib_dir}/"), "")
              source_file = "#{source_uri}/#{lib_dir}/#{file_id}"

              package.set_file("lib/#{file_id}", File.read(source_file)) if File.file?(source_file)
            end
          end
        ensure
          package.close
        end

      end

      private

      def clean_path(path)
        path = path.dup

        if path[-1..-1] == File::SEPARATOR
          path.chop!
        end

        path
      end

    end
        
  end
end
