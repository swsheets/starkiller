module Starkiller
  module Components
    module TalentTable
      include Starkiller::Component

      LABEL_OFFSET = 8
      LABEL_NAME_LEFT = 4
      LABEL_BOOK_LEFT = 30
      LABEL_DESCRIPTION_LEFT = 60
      LABEL_SIZE = 5
      LABEL_COLOR = "999999"

      TALENT_HEIGHT = 10

      class << self
        def render(pdf, character)
          within(pdf,
            top: Starkiller::Components::AttackTable::BOTTOM - 22,
            left: 0,
            width: Starkiller::Components::AttackTable::RIGHT,
            height: 100
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

            table_header(pdf, "TALENTS",
              horizontal_center: full_width / 2.0,
              vertical_center: 0,
              width: 46
            )

            write(pdf, "NAME",
              top: 0 - LABEL_OFFSET,
              left: LABEL_NAME_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            write(pdf, "BOOK & PAGE",
              top: 0 - LABEL_OFFSET,
              left: LABEL_BOOK_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            write(pdf, "DESCRIPTION",
              top: 0 - LABEL_OFFSET,
              left: LABEL_DESCRIPTION_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            vertical_offset = 0 - LABEL_OFFSET - 6.5
            talent_count = character[:talents].length

            character[:talents].each_with_index do |t, i|
              render_talent(pdf, t, vertical_offset)
              vertical_offset -= TALENT_HEIGHT
              draw_talent_line(pdf, vertical_offset, dashed: i != talent_count - 1)
            end
          end
        end

        def render_talent(pdf, talent, vertical_offset)
          write(pdf, talent[:name],
            top: vertical_offset,
            left: LABEL_NAME_LEFT,
            width: LABEL_BOOK_LEFT - LABEL_NAME_LEFT,
            size: 7.0,
            font: FONT_MINOR_TEXT
          )

          write(pdf, talent[:book_and_page],
            top: vertical_offset,
            left: LABEL_BOOK_LEFT,
            width: LABEL_DESCRIPTION_LEFT - LABEL_BOOK_LEFT,
            size: 7.0,
            font: FONT_MINOR_TEXT
          )

          write(pdf, talent[:description],
            top: vertical_offset,
            left: LABEL_DESCRIPTION_LEFT,
            width: full_width - LABEL_DESCRIPTION_LEFT,
            size: 7.0,
            font: FONT_MINOR_TEXT
          )
        end

        def draw_talent_line(pdf, vertical_offset, options)

        end
      end
    end
  end
end
