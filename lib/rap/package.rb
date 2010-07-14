require 'rap/package/zipped'

module Rap
  module Package

    class << self
      def open(filename)
        Package::Zipped.open(filename)
      end

      def create(filename)
        Package::Zipped.create(filename)
      end
    end

  end
end