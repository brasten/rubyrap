require 'fileutils'
require 'spec_helper'
require 'rap/transport/shared_examples'
require 'rap/transport/file'

module Rap::Transport

  describe File, :fixtures => true do
    subject {
      context_mock = mock(:context)
      context_mock.stub!(:base_uri).and_return(tmp_path.to_s)

      File.new(:context => context_mock)
    }
    
    it_should_behave_like 'a Rap::Transport implementation'

    describe '#exists' do
      it "returns true if file exists" do
        subject.exists?('/repository/rack.new_router/0.1.0/lib/rack.new_router.rb').should be_true
      end
      
      it "returns false if file does not exist" do
        subject.exists?('/repository/rack.old_router/1.0.0').should be_false
      end
    end
    
    describe '#get' do
      it "returns content of file if it exists" do
        content = subject.get('/repository/rack.new_router/0.1.0/lib/rack.new_router.rb')
      
        content.should eql(::File.read(tmp_path('repository/rack.new_router/0.1.0/lib/rack.new_router.rb')))
      end
    end
    
    describe '#put' do
      it "writes contents to file" do
        contents = <<-EOC
module Rack
  class Test
    def hi; puts "hi"; end
  end
end
EOC

        subject.put('/repository/rack.new_router/0.1.0/lib/rack.new_router/test.rb', contents)
        
        ::File.read(tmp_path('repository/rack.new_router/0.1.0/lib/rack.new_router/test.rb')).should eql(contents)
      end
    end
    
    describe '#create_directory' do
      it 'creates a directory' do
        ::File.exists?(tmp_path('repository/rack.new_router/0.1.0/lib/rack.old_router')).should be_false
        subject.create_directory('/repository/rack.new_router/0.1.0/lib/rack.old_router')
        ::File.exists?(tmp_path('repository/rack.new_router/0.1.0/lib/rack.old_router')).should be_true
      end
    end

    # describe '#remove_directory' do
    #   it 'removes a directory' do
    #     dir = tmp_path('repository/rack.new_router/0.1.0.snapshot')
    #     
    #     ::File.exists?(dir).should be_true
    #     subject.remove_directory(dir)
    #     ::File.exists?(dir).should be_false
    #   end
    # end

    describe '#list' do
      context 'for /repository/rack.new_router' do
        before(:each) do
          @list = subject.list('/repository/rack.new_router')
        end

        it 'has 2 items' do
          @list.should have(2).items
        end
        
        it 'has both versions of rack.new_router' do
          @list.should include('/repository/rack.new_router/0.1.0/')
          @list.should include('/repository/rack.new_router/0.1.0.snapshot/')
        end
      end

      context 'for /repository/rack.new_router/0.1.0' do
        before do
          @list = subject.list('/repository/rack.new_router/0.1.0')
        end

        it do
          @list.should == ['/repository/rack.new_router/0.1.0/lib/',
                           '/repository/rack.new_router/0.1.0/lib2/',
                           '/repository/rack.new_router/0.1.0/spec/',
                           '/repository/rack.new_router/0.1.0/rack.new_router.descriptor']
        end
#
#
#          @list.should have(4).items
#          @list[0].should == '/repository/rack.new_router/0.1.0/lib/'
#          @list[1].should == '/repository/rack.new_router/0.1.0/lib2/'
#          @list[2].should == '/repository/rack.new_router/0.1.0/spec/'
#          @list[3].should == '/repository/rack.new_router/0.1.0/rack.new_router.descriptor'
      end
    end
    
  end

end

# def get( uri )
#   ::File.read(uri)
# end
# 
# def put( uri, content_io )
#   ::File.open(uri, "w") do |file|
#     file.write(content_io.read)
#   end
# end
# 
# def create_directory( uri )
#   ::FileUtils.mkdir(uri)
# end
# 
# def remove_directory( uri )
#   ::FileUtils.rmdir(uri)
# end
# 
# def list( uri )
#   ::Dir[uri].map { |d| ::File.directory?(d) ? "#{d}/" : d }
# end