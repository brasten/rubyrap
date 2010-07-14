require 'spec_helper'
require 'rap/package/folder'
require 'rap/descriptor'

describe Rap::Package::Folder do

  describe "with existing package" do

    before(:each) do
      @package = Rap::Package::Folder.open('spec/projects/test.my_package-folder')
    end

    describe "#manifest" do
      subject { @package.manifest }
      it { should have(9).items }

      it { should include("test.my_package.descriptor") }
      it { should include("lib/") }
      it { should include("lib/test.my_package/") }
      it { should include("lib/test.my_package/router/") }
      it { should include("lib/test.my_package/router/mixin_one.rb") }
      it { should include("lib/test.my_package/router/mixin_two.rb") }
      it { should include("lib/test.my_package/router.rb") }
      it { should include("lib/test.my_package/version.rb") }
      it { should include("lib/test.my_package.rb") }
    end

    describe "#get_file(lib/test.my_package/router/mixin_one.rb)" do
      subject { @package.get_file('lib/test.my_package/router/mixin_one.rb') }

      it {
        should eql(<<-EOV.chop)
module Rack
  module Router
    module MixinOne

      def do_something
        return false
      end

    end
  end
end
        EOV
      }
    end

    describe "#descriptor_filename" do
      subject { @package.descriptor_filename }
      it { should == "test.my_package.descriptor" }
    end

    describe "#name" do
      subject { @package.name }
      it { should == "test.my_package" }
    end

    describe "#title" do
      subject { @package.title }
      it { should == "New Package" }
    end

    describe "#version" do
      subject { @package.version }
      it { should == "0.2.0.snapshot" }
    end

    describe "#description" do
      subject { @package.description }
      it { should include('It does something pretty cool') }
    end

    describe "#homepage" do
      subject { @package.homepage }
      it { should == "www.example.org" }
    end

  end

end