module Rap
  
  def self.repository
    Rap::Repository.new()
  end
  
  class Repository

    def initialize(dir)
      @base_dir = dir
    end
    
    
  end
end