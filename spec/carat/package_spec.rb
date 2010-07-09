require 'spec_helper'
require 'carat/package'
require 'rubygems/specification'

describe Carat::Package do
  
  describe "with gemfile" do
    before do
      @package = Carat::Package.new(File.expand_path('../../gems/rack-1.2.1.gem', __FILE__))
    end
    
    it "can access gem specification" do
      @package.spec.should be_instance_of(Gem::Specification)
    end

    describe "#body_for()" do
      it "returns the text of the requested file" do
        @package.body_for('bin/rackup').should match(/Rack\:\:Server\.start/)
      end
    end

    
  end
  
  
end