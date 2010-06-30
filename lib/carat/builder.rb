require 'carat/definition'

module Carat
  class Builder
   
    attr_reader :directory
    attr_reader :definition
   
    def initialize(directory, opts={})
      @directory = directory
      
      @definition = options[:definition] || Carat::Definition.load( File.join(directory, 'Carat') )
    end
    
    
  end
end