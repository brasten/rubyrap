require 'spec_helper'
require 'fileutils'
require 'rap/package/folder'
require 'rap/package/shared_examples'


module Rap
  module Package

    describe Folder do

      before(:each) do
        rap = 'test.my_package-folder'
        FileUtils.rm_rf("spec/artifacts/#{rap}") if File.exists?("spec/artifacts/#{rap}")

        FileUtils.cp_r("spec/projects/#{rap}", "spec/artifacts/#{rap}")
      end

      after(:each) do
        rap = 'test.my_package-folder'
        FileUtils.rm_rf("spec/artifacts/#{rap}") if File.exists?("spec/artifacts/#{rap}")
      end
      
      let :package do
        Folder.open('spec/artifacts/test.my_package-folder')
      end

      let :expected_descriptor do
        {
          :name         => "test.my_package",
          :title        => "New Package",
          :version      => "0.3.0.snapshot",
          :description  => "It does something pretty cool",
          :homepage     => "www.example.org"
        }
      end

      let :expected_manifest do
        %w(
          Rapfile
          lib/
          lib/test.my_package/
          lib/test.my_package/router/
          lib/test.my_package/router/mixin_one.rb
          lib/test.my_package/router/mixin_two.rb
          lib/test.my_package/router/mixin_three.rb
          lib/test.my_package/router.rb
          lib/test.my_package/version.rb
          lib/test.my_package.rb
        )
      end

      it_should_behave_like "package interface"

    end
  end
end
