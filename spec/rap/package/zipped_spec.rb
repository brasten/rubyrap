require 'spec_helper'
require 'rap/package/zipped'
require 'rap/package/shared_examples'

module Rap
  module Package

    describe Zipped do

      let :rap_name do
        'test.my_package-0.2.0.snapshot.rib'
      end

      before(:each) do
        FileUtils.rm(SH.artifacts_path.join(rap_name)) if File.exists?(SH.artifacts_path.join(rap_name))

        FileUtils.cp(SH.projects_path.join(rap_name), SH.artifacts_path.join(rap_name))
      end

      after(:each) do
        FileUtils.rm(SH.artifacts_path.join(rap_name)) if File.exists?(SH.artifacts_path.join(rap_name))
      end

      let :package do
        Zipped.open(SH.artifacts_path.join(rap_name))
      end

      let :expected_descriptor do
        {
          :name => "test.my_package",
          :title => "New Package",
          :version => "0.2.0.snapshot",
          :description => "It does something pretty cool",
          :homepage => "www.example.org"
        }
      end

      let :expected_manifest do
        %w(
          test.my_package.descriptor
          lib/
          lib/test.my_package/
          lib/test.my_package/router/
          lib/test.my_package/router/mixin_one.rb
          lib/test.my_package/router/mixin_two.rb
          lib/test.my_package/router.rb
          lib/test.my_package/version.rb
          lib/test.my_package.rb
        )
      end

      it_should_behave_like "package interface"      

    end

  end
end
