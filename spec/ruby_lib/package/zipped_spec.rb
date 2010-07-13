require 'spec_helper'
require 'ruby_lib/package/zipped'

describe 'RubyLib::Package::Zipped' do

  describe "with zipped package" do

    def package_name
      File.expand_path('../../../projects/rack.new_router-0.1.0.snapshot.rib', __FILE__)
    end

    before(:each) do
      @package = RubyLib::Package::Zipped.new(package_name)
    end

    describe "#manifest" do

      before(:each) do
        subject = @package.manifest
      end

      it { should include('rack.new_router.descriptor') }      

    end

  end

end