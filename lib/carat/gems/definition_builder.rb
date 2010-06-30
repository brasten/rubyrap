module Carat
  module Gems
    class DefinitionBuilder

      class << self
        def from_specification(specification)
          Carat::Definition.new do |c|

            %w(name version platform authors email
               homepage summary description bindir files
               executables require_path).each do |att|
                 
              c.send("#{att}=".to_sym, specification.send(att.to_sym))
            end
            
          end
        end
      end
      
    end
  end
end