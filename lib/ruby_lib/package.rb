module RubyLib
  module Package

    class << self
      def from_zipped(filename)
        Package::Zipped.new(filename)
      end
    end

  end
end