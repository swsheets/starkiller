module Starkiller
  module Components
    module AttackTable
      include Starkiller::Component
      extend Starkiller::Dice

      class << self
        def render(pdf, character)
          left = DOCUMENT_LEFT + Starkiller::Components::Characteristics::BOX_SIZE + Starkiller::Components::Characteristics::PADDING + 10
          within(pdf,
            top: DOCUMENT_TOP - 44,
            left: left,
            width: Starkiller::Components::SkillTable::COMPONENT_LEFT - left - 10,
            height: 500
          ) do
            draw_rectangle(pdf,
              top: 0,
              left: 0,
              width: full_width,
              height: full_height,
              fill_color: COLOR_TABLE_BACKGROUND,
              stroke_color: COLOR_TABLE_FOREGROUND,
              line_width: 0.2
            )

            table_header(pdf, "ATTACKS",
              horizontal_center: full_width / 2.0,
              vertical_center: 0,
              width: 40
            )
          end
        end
      end
    end
  end
end
