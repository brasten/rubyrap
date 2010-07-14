require 'spec_helper'
require 'zip/zip'
require 'ruby_lib/package/validator'

describe 'RubyLib::Package::Validator' do

  describe "#validate!" do

    def package_name
      'spec/artifacts/ruby_lib.test_package-0.2.0.rib'
    end

    def valid_descriptor
      <<-EOV
project:
  name: ruby_lib.test_package
  title: Test Package
  version: 0.2.0.snapshot
  descriptor: |
    Test Package

  homepage: www.example.org

  authors:
    - name: John Doe
      email: johndoe@email.com

    - name: Jane Doe
      email: janedoe@email.com

  dependencies:
    - name: rack
      version: ~ 1.1.0

    - name: rake
      EOV
    end

    def make_package(opts={})
      name          = opts[:name]
      package       = opts[:package]
      descriptor    = opts[:descriptor]
      files         = opts[:files]

      writer = Proc.new { |os| os.puts "Test" }
      descriptor_writer = Proc.new { |os| os.puts descriptor }

      Zip::ZipFile.open(package, Zip::ZipFile::CREATE) do |zip|
        files.each { |f| zip.get_output_stream(f, &writer) }
        zip.get_output_stream("#{name}.descriptor", &descriptor_writer)
      end
    end

    before(:each) do
      FileUtils.rm(package_name) if File.exists?(package_name)

      @validator = RubyLib::Package::Validator.new(package_name)
    end

    after(:each) do
      FileUtils.rm(package_name) if File.exists?(package_name)
    end

    it "successfully validates a valid package" do
      make_package(
        :name => 'ruby_lib.test_package',
        :package => package_name,
        :descriptor => valid_descriptor,
        :files => %w(
          lib/ruby_lib.test_package.rb
          lib/ruby_lib.test_package/file_one.rb
          lib/ruby_lib.test_package/file_two.rb
        )
      )

      @validator.should be_valid
    end

    it "does not validate on polluted top namespace" do
      make_package(
        :name => 'ruby_lib.test_package',
        :package => package_name,
        :descriptor => valid_descriptor,
        :files => %w(
          lib/ruby_lib.test_package.rb
          lib/some_other_file.rb
          lib/ruby_lib.test_package/file_one.rb
          lib/ruby_lib.test_package/file_two.rb
        )
      )

      @validator.should_not be_valid
    end




  end


end