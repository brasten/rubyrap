require 'yaml'

module Rap
  class Descriptor

    class << self

      def from_hash(hash)
        new(hash)
      end

      def from_yaml(yaml_string)
        new(YAML.load(yaml_string))
      end

    end

    def initialize(args=nil, &block)
      @hash = args.nil? ? {} : args['project'].clone

      yield(self) if block_given?
    end

    def default_package_name
      pkg = []
      pkg << name
      pkg << version
      pkg << platform if platform

      "#{pkg.join('-')}.rib"
    end

    def platform
      nil
    end

    %w(name title version description homepage).each do |attribute|
      self.send(:define_method, attribute.to_sym) do
        hash[attribute.to_s]
      end
      
      self.send(:define_method, "#{attribute.to_s}=".to_sym) do |val|
        hash[attribute.to_s] = val
      end
    end

    def authors
      hash['authors'] ||= []
    end
    
    def dependencies
      hash['dependencies'] ||= []
    end
    
    def build(&block)
      hash['build'] ||= {}
      
      yield(Build.new(hash['build'])) if block_given?

      Build.new(hash['build'])
    end

    def add_authors(authors)
      case authors
        when Hash
          add_authors([authors])
        when Array
          authors.each do |author|
            add_author(author)
          end
      end
    end

    def add_author(author)
      self.authors << author
    end

    def add_dependencies(deps)
      case deps
        when Hash
          add_dependencies([deps])
        when Array
          deps.each do |dep|
            add_dependency(dep)
          end
      end
    end

    def add_dependency(dep)
      self.dependencies << dep
    end
    
    def to_hash
      {'project' => hash}
    end

    def to_yaml
      YAML.dump(to_hash)
    end


    private
    
    def hash
      @hash
    end

    class Build

      def initialize(hash)
        @hash = hash
      end

      def lib
        @hash['lib'] ||= []
      end
      
      private
      
      def hash
        @hash
      end
    end

  end
end