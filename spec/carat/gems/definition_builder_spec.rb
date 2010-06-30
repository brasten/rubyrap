require 'spec_helper'
require 'carat/gems/definition_builder'
require 'rubygems/specification'

describe Carat::Gems::DefinitionBuilder do
  
  describe "with specification" do

    before do
      specification = Gem::Specification.new do |s|
        s.name = %q{bundler}
        s.version = "0.9.26"

        s.authors = ["Carl Lerche", "Yehuda Katz"]
        s.description = %q{Bundler manages an application's dependencies through its entire life, across many machines, systematically and repeatably}
        s.email = ["carlhuda@engineyard.com"]
        s.executables = ["bundle"]
        s.files = ["bin/bundle", "lib/bundler/cli.rb", "lib/bundler/definition.rb", "lib/bundler/dependency.rb", "lib/bundler/dsl.rb", "lib/bundler/environment.rb", "lib/bundler/index.rb", "lib/bundler/installer.rb", "lib/bundler/remote_specification.rb", "lib/bundler/resolver.rb", "lib/bundler/rubygems_ext.rb", "lib/bundler/runtime.rb", "lib/bundler/settings.rb", "lib/bundler/setup.rb", "lib/bundler/shared_helpers.rb", "lib/bundler/source.rb", "lib/bundler/spec_set.rb", "lib/bundler/templates/environment.erb", "lib/bundler/templates/Gemfile", "lib/bundler/ui.rb", "lib/bundler/vendor/thor/base.rb", "lib/bundler/vendor/thor/core_ext/file_binary_read.rb", "lib/bundler/vendor/thor/core_ext/hash_with_indifferent_access.rb", "lib/bundler/vendor/thor/core_ext/ordered_hash.rb", "lib/bundler/vendor/thor/error.rb", "lib/bundler/vendor/thor/invocation.rb", "lib/bundler/vendor/thor/parser/argument.rb", "lib/bundler/vendor/thor/parser/arguments.rb", "lib/bundler/vendor/thor/parser/option.rb", "lib/bundler/vendor/thor/parser/options.rb", "lib/bundler/vendor/thor/parser.rb", "lib/bundler/vendor/thor/shell/basic.rb", "lib/bundler/vendor/thor/shell/color.rb", "lib/bundler/vendor/thor/shell.rb", "lib/bundler/vendor/thor/task.rb", "lib/bundler/vendor/thor/util.rb", "lib/bundler/vendor/thor/version.rb", "lib/bundler/vendor/thor.rb", "lib/bundler/version.rb", "lib/bundler.rb", "LICENSE", "README.md", "ROADMAP.md", "CHANGELOG.md"]
        s.homepage = %q{http://github.com/carlhuda/bundler}
        s.require_paths = ["lib"]
        s.summary = %q{The best way to manage your application's dependencies}
      end
      
      
      @definition = 
        Carat::Gems::DefinitionBuilder.from_specification( specification )
    end
    
    it "has name" do
      @definition.name.should == 'bundler'
    end
  end

end