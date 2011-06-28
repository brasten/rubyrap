module Rap
  class << self

    # Return a repository for the specified URI
    #
    # @param [String] repo_uri the uri to the desired repository. Default is ~/.rubyrap
    # @return [Rap::Repository::File]
    #
    def repository(repo_uri=nil)
      # TODO select repository type based on URI. Right now we just assume a File repo.

      base_dir = repo_uri || File.join(ENV['HOME'], '.rubyrap')

      require 'ostruct'
      require 'rap/repository/filesystem'

      context = OpenStruct.new(:base_uri => base_dir)

      Repository::Filesystem.new(:context => context)
    end
  end
end

%w(config package).each do |f|
  require "rap/#{f}"
end
