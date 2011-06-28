require 'fileutils'
require 'pathname'
require 'rap/repository/base'

module Rap::Repository

  # Repository implementation for file-based repositories
  #
  # TODO split this out into simple and complex file systems?  Simple for basic project repositories,
  #      and complex to allow for performance enhancements, statistics, etc.
  #
  class Filesystem < Base

    def libraries
      list('/')
    end

    def get( uri )
      ::File.read(full_path(uri))
    end

    def put( uri, content_io )
      ::File.open(full_path(uri), "w") do |file|
        file.write(content_io.respond_to?(:read) ? content_io.read : content_io)
      end
    end

    def create_directory( uri )
      ::FileUtils.mkdir(full_path(uri))
    end
    
    def remove_directory( uri )
      # ::FileUtils.rmdir(full_path(uri))
    end

    # Return a list of entries
    #
    # :return: => Array
    #
    def list( uri )
      uri_path = full_path(uri)
      base_path = full_path('/')

      entries = ::Dir[::File.join(uri_path, '*')]

      directories = entries.find_all { |e| ::File.directory?(e) }
      files       = entries.find_all { |e| !::File.directory?(e) }

      # return merged list
      directories.map { |d| '/' + Pathname.new(d).relative_path_from(base_path).to_s + '/' }.sort +
        files.map { |f| '/' + Pathname.new(f).relative_path_from(base_path).to_s }.sort
    end

    def exists?( uri )
      ::File.exists?(full_path(uri))
    end   
    
    protected
    
    def full_path(path='/')
      base = normalize_base(context.base_uri)
            
      Pathname.new(base).join(normalize_path(path))
    end
    
    def normalize_base(base)
      base.sub(/([^\/]$)/, '\1/')
    end
    
    def normalize_path(path)
      path.sub(/^\//, '')
    end
    
  end
end