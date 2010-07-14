module Rap

  class RapError < StandardError; end
  class NoPackageError < RapError; end
  class InvalidTypeError < RapError; end

end

%w(config package repository).each do |f|
  require File.expand_path("../rap/#{f}")
end
