module Carat
  
  def self.repository
    Carat::Repository.new()
  end
  
  class Repository

    def initialize(dir)
      @base_dir = dir
    end
    
    
  end
end