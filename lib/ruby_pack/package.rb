require 'ruby_pack/package/zipped'

module RubyPack
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