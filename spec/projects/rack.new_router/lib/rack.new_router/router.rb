require 'rack.new_router/router/mixin_one'
require 'rack.new_router/router/mixin_two'

module Rack
  class NewRouter
    include Router::MixinOne
    include Router::MixinTwo

  end
end