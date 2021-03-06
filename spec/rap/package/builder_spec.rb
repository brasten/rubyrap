require 'spec_helper'
require 'rap/package/builder'
require 'rap/descriptor'

describe 'Rap::Package::Builder' do

  describe "#package!" do

    def package_name
      SH.projects_path.join('rack.new_router/rack.new_router-0.1.0.snapshot.rap')
    end

    def remove_package!
      FileUtils.rm(package_name) if File.exists?(package_name)
    end

    before(:each) do
      remove_package!

      @builder = Rap::Package::Builder.new(
                   Rap::Descriptor.from_yaml(File.read("spec/projects/rack.new_router/Rapfile")),
                   "spec/projects/rack.new_router"
                 )

      @builder.package!
    end

    it "builds a rap file" do
      File.exists?(package_name).should be_true
    end

    it "contains files from lib" do
      file_list = `unzip -l #{package_name}`

      file_list.should match('lib/rack.new_router.rb')
      file_list.should match('lib/rack.new_router/version.rb')
      file_list.should match('lib/rack.new_router/router.rb')
      file_list.should match('lib/rack.new_router/router/mixin_one.rb')
      file_list.should match('lib/rack.new_router/router/mixin_two.rb')
    end

    it "contains files from lib2" do
      file_list = `unzip -l #{package_name}`

      file_list.should match('lib/rack.new_router/example_app.rb')
    end

    it "contains file contents" do
      contents = `unzip -p #{package_name} lib/rack.new_router.rb`

      contents.should match(File.open('spec/projects/rack.new_router/lib/rack.new_router.rb').read)
    end



    after(:each) do
      remove_package!
    end
  end

end