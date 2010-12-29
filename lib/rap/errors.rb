module Rap
  class RapError < StandardError; end
  class NoPackageError < RapError; end
  class InvalidTypeError < RapError; end
end