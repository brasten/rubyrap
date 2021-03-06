require 'spec_helper'
require 'rap/package/validator'

describe 'Rap::Package::Validator' do

  describe "#validate!" do

    def package_name
      'spec/artifacts/rap.test_package-0.2.0.rap'
    end

    def valid_descriptor
      <<-EOV
project:
  name: rap.test_package
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
        zip.get_output_stream("Rapfile", &descriptor_writer)
      end
    end

    before(:each) do
      FileUtils.rm(package_name) if File.exists?(package_name)

      @validator = Rap::Package::Validator.new(package_name)
    end

    after(:each) do
      FileUtils.rm(package_name) if File.exists?(package_name)
    end

    it "successfully validates a valid package" do
      pending "Validation is not yet implemented"
      
      make_package(
        :name => 'rap.test_package',
        :package => package_name,
        :descriptor => valid_descriptor,
        :files => %w(
          lib/rap.test_package.rb
          lib/rap.test_package/file_one.rb
          lib/rap.test_package/file_two.rb
        )
      )

      @validator.should be_valid
    end

    it "does not validate on polluted top namespace" do
      pending "Validation is not yet implemented"
      
      make_package(
        :name => 'rap.test_package',
        :package => package_name,
        :descriptor => valid_descriptor,
        :files => %w(
          lib/rap.test_package.rb
          lib/some_other_file.rb
          lib/rap.test_package/file_one.rb
          lib/rap.test_package/file_two.rb
        )
      )

      @validator.should_not be_valid
    end




  end


end