$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

module Carat; end

%w(config definition package repository).each do |f|
  require File.expand_path("../carat/#{f}")
end
