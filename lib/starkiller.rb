require 'prawn'

require_relative "starkiller/editing"
require_relative "starkiller/renderer"
require_relative "starkiller/component"
require_relative "starkiller/dice"
Dir.glob("lib/starkiller/components/*.rb").each { |f| require_relative f.gsub("lib/", "") }

module Starkiller
  class << self
    def render(character)
      pdf = Prawn::Document.new
      Renderer.render(pdf, character)
      save(pdf)
    end

    def save(pdf)
      pdf.render_file "tmp/test.pdf"
    end
  end
end
