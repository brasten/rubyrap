module RubyPack
  
  def self.repository
    RubyPack::Repository.new()
  end
  
  class Repository

    def initialize(dir)
      @base_dir = dir
    end
    
    
  end
end