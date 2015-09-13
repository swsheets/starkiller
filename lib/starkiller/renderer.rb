module Starkiller
  module Renderer
    extend Starkiller::Editing

    @components = []
    class << self
      def add_component(klass)
        @components << klass
      end

      def render(pdf, character)
        @components.each do |component|
          component.render(pdf, character)
        end
      end
    end
  end
end
