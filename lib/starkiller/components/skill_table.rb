module Starkiller
  module Components
    module SkillTable
      include Starkiller::Component

      SKILL_LABEL_OFFSET = 8
      SKILL_NAME_LEFT = 4
      SKILL_CAREER_LEFT = 90
      SKILL_RANK_LEFT = 110

      class << self
        def render(pdf, character)
          within(pdf,
            top: DOCUMENT_TOP - 45,
            left: 360,
            width: DOCUMENT_WIDTH - 360,
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

            table_header(pdf, "SKILLS",
              horizontal_center: full_width / 2.0,
              vertical_center: 0,
              width: 40
            )

            write(pdf, "SKILL",
              top: 0 - SKILL_LABEL_OFFSET,
              left: SKILL_NAME_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: 5,
              color: "969696"
           )

            write(pdf, "CAREER?",
              top: 0 - SKILL_LABEL_OFFSET,
              left: SKILL_CAREER_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: 5,
              color: "969696"
           )

            write(pdf, "RANK",
              top: 0 - SKILL_LABEL_OFFSET,
              left: SKILL_RANK_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: 5,
              color: "969696"
           )
          end
        end
      end
    end
  end
end
