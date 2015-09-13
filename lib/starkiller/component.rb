module Starkiller
  module Component
    def self.included(klass)
      Starkiller::Renderer.add_component(klass)
      klass.extend(Starkiller::Editing)
    end
  end
end
