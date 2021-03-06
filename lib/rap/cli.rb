$:.unshift File.expand_path('../vendor', __FILE__)
require 'thor'

module Rap
  class CLI < Thor
    check_unknown_options! unless ARGV.include?("exec")

    desc "list", "List the available Raps"
    def list()
      require 'rap'

      repo = Rap.repository()
      puts "Listing stuff..."

      repo.list('/').each do |rap|
        puts rap
      end
    end
  end
end
