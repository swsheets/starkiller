module Starkiller
  module Components
    module Vitals
      include Starkiller::Component
      extend Starkiller::Dice

      HORIZONTAL_BUFFER = 10
      BORDER_WIDTH = 0.6
      BOX_WIDTH = 50
      BOX_HEIGHT = 37

      class << self
        def render(pdf, character)
          left = DOCUMENT_LEFT + Starkiller::Components::Characteristics::BOX_SIZE + Starkiller::Components::Characteristics::PADDING + 10

          within(pdf,
            top: DOCUMENT_TOP - 45,
            left: left,
            width: Starkiller::Components::SkillTable::COMPONENT_LEFT - left - 10,
            height: 55
          ) do

            width = (full_width - 3 * HORIZONTAL_BUFFER) / 4.0

            draw_soak(pdf, character[:soak])
          end
        end

        def draw_soak(pdf, soak)
          draw_rectangle(pdf,
            top: 0,
            left: 0,
            fill_color: "ffffff",
            stroke_color: "000000",
            line_width: BORDER_WIDTH,
            width: 50,
            height: 37
          )

          draw_rectangle(pdf,
            top: 0 - BORDER_WIDTH / 2.0,
            left: 0 + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: 50 - BORDER_WIDTH,
            height: 13
          )

          write(pdf, "SOAK",
            top: -3,
            left: 0 + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: 50 - BORDER_WIDTH,
            align: :center,
            size: 9.0,
            font: FONT_HEADING,
            color: "ffffff",
            character_width: 0.8
          )

          write(pdf, soak,
            top: -18,
            left: 0 + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: 50 - BORDER_WIDTH,
            align: :center,
            size: 18.0,
            font: FONT_MAJOR_NUMBER,
            color: "000000",
          )
        end
      end
    end
  end
end
