module Rap
  ; end

%w(config package repository).each do |f|
  require File.expand_path("../rap/#{f}")
end
