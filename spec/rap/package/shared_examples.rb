
module Rap
  module Package
    
    shared_examples_for "package interface" do
      context "with existing package" do

        describe "#manifest" do
          subject { package.manifest }
          it { should have(expected_manifest.count).items }

          it { should include(*expected_manifest) }
        end

        describe "#get_file(lib/test.my_package/router/mixin_one.rb)" do
          subject { package.get_file('lib/test.my_package/router/mixin_one.rb') }

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

        describe "#set_file(lib/test.my_package/router/mixin_four.rb)" do
          before do
            package.set_file('lib/test.my_package/router/mixin_four.rb', "module MixinFour; end\n")
          end

          it "resulting entry should be retrievable" do
            package.get_file('lib/test.my_package/router/mixin_four.rb').should == "module MixinFour; end\n"
          end

          it "manifest should include resulting entry" do
            package.manifest.should include('lib/test.my_package/router/mixin_four.rb')
          end
        end

        describe "#descriptor_filename" do
          subject { package.descriptor_filename }
          it { should == "Rapfile" }
        end

        describe "#name" do
          subject { package.name }
          it { should == expected_descriptor[:name] }
        end

        describe "#title" do
          subject { package.title }
          it { should == expected_descriptor[:title] }
        end

        describe "#version" do
          subject { package.version }
          it { should == expected_descriptor[:version] }
        end

        describe "#description" do
          subject { package.description }
          it { should include(expected_descriptor[:description]) }
        end

        describe "#homepage" do
          subject { package.homepage }
          it { should == expected_descriptor[:homepage] }
        end

      end
    end

  end
end