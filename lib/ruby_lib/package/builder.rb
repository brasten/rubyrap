require 'zip/zipfilesystem'
require 'ruby_lib/descriptor'

module RubyLib
  module Package
    class Builder

      attr_reader :descriptor_filename, :descriptor

      def initialize(descriptor_filename)
        @descriptor_filename = descriptor_filename

        my_def = YAML.load_file(self.descriptor_filename)
        @descriptor = RubyLib::Descriptor.new(my_def['project'])
      end

      def root_dir
        File.dirname(self.descriptor_filename)
      end

      def package!
        Zip::ZipFile.open("#{self.root_dir}/#{self.descriptor.package_name}", Zip::ZipFile::CREATE) do |zipfile|
          @descriptor.build.lib.each do |lib_dir|
            Dir["#{root_dir}/#{lib_dir}/**/*"].each do |lib_file|
              file_id = lib_file.gsub(Regexp.new("^#{root_dir}/#{lib_dir}/"), "")
              zipfile.add("lib/#{file_id}", "#{root_dir}/#{lib_dir}/#{file_id}")
            end
          end
        end
      end


    end
        
  end
end
