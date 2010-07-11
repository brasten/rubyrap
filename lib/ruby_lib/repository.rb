module RubyLib
  
  def self.repository
    RubyLib::Repository.new()
  end
  
  class Repository

    def initialize(dir)
      @base_dir = dir
    end
    
    
  end
end