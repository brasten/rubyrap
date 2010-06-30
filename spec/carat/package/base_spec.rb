require 'spec_helper'
require 'carat/package/base'

describe Carat::Package::Base do
  
  describe "with bundler-0.9.26.gem" do
    before do
      @package = Carat::Package::Base.new( File.expand_path('../../../gems/bundler-0.9.26.gem', __FILE__) )
    end

    
  
end