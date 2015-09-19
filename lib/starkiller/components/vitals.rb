module Starkiller
  module Components
    module Vitals
      include Starkiller::Component
      extend Starkiller::Dice

      HORIZONTAL_BUFFER = 10

      class << self
        def render(pdf, character)
          left = DOCUMENT_LEFT + Starkiller::Components::Characteristics::BOX_SIZE + Starkiller::Components::Characteristics::PADDING + 10

          within(pdf,
            top: DOCUMENT_TOP - 326,
            left: left,
            width: Starkiller::Components::SkillTable::COMPONENT_LEFT - left - 10,
            height: 55
          ) do

            width = (full_width - 3 * HORIZONTAL_BUFFER) / 4.0

            draw_rectangle(pdf,
              top: 0,
              left: 0,
              fill_color: "000000",
              width: (full_width - 3 * HORIZONTAL_BUFFER) / 4.0,
              height: full_height
            )

            draw_rectangle(pdf,
              top: 0,
              left: width + HORIZONTAL_BUFFER,
              fill_color: "000000",
              width: (full_width - 3 * HORIZONTAL_BUFFER) / 4.0,
              height: full_height
            )

            draw_rectangle(pdf,
              top: 0,
              left: (width + HORIZONTAL_BUFFER) * 2,
              fill_color: "000000",
              width: (full_width - 3 * HORIZONTAL_BUFFER) / 4.0,
              height: full_height
            )

            draw_rectangle(pdf,
              top: 0,
              left: (width + HORIZONTAL_BUFFER) * 3,
              fill_color: "000000",
              width: (full_width - 3 * HORIZONTAL_BUFFER) / 4.0,
              height: full_height
            )
          end
        end
      end
    end
  end
end
