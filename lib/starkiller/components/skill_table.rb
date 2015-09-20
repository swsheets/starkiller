module Starkiller
  module Components
    module SkillTable
      include Starkiller::Component
      extend Starkiller::Dice

      COMPONENT_LEFT = 380

      SKILL_LABEL_OFFSET = 8
      SKILL_NAME_LEFT = 4
      SKILL_CAREER_LEFT = 82.5
      SKILL_RANK_LEFT = 102
      SKILL_ROLL_LEFT = 115.5
      SKILL_HEIGHT = 10

      LABEL_SIZE = 5
      LABEL_COLOR = "999999"

      class << self
        def render(pdf, character)
          within(pdf,
            top: DOCUMENT_TOP - 44,
            left: COMPONENT_LEFT,
            width: DOCUMENT_WIDTH - COMPONENT_LEFT,
            # 22.3 is the height of everything else in the table aside from the skill length
            height: 22.3 + (character[:skills][:general].length + character[:skills][:combat].length + character[:skills][:knowledge].length) * SKILL_HEIGHT
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
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            write(pdf, "CAREER?",
              top: 0 - SKILL_LABEL_OFFSET,
              left: SKILL_CAREER_LEFT,
              font: FONT_MINOR_LABEL,
              width: SKILL_RANK_LEFT - SKILL_CAREER_LEFT,
              align: :center,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            write(pdf, "RANK",
              top: 0 - SKILL_LABEL_OFFSET,
              left: SKILL_RANK_LEFT,
              font: FONT_MINOR_LABEL,
              width: SKILL_ROLL_LEFT - SKILL_RANK_LEFT,
              align: :center,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            write(pdf, "TOTAL ROLL",
              top: 0 - SKILL_LABEL_OFFSET,
              left: SKILL_ROLL_LEFT + 1,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            vertical_offset = 0 - SKILL_LABEL_OFFSET - 6.5
            skill_count = character[:skills][:general].length

            character[:skills][:general].each_with_index do |s, i|
              render_skill(pdf, s, vertical_offset)
              vertical_offset -= SKILL_HEIGHT
              draw_skill_line(pdf, vertical_offset, dashed: i != skill_count - 1)
            end

            write(pdf, "COMBAT SKILL",
              top: vertical_offset,
              left: SKILL_NAME_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            vertical_offset -= 5
            skill_count = character[:skills][:combat].length

            character[:skills][:combat].each_with_index do |s, i|
              render_skill(pdf, s, vertical_offset)
              vertical_offset -= SKILL_HEIGHT
              draw_skill_line(pdf, vertical_offset, dashed: i != skill_count - 1)
            end

            write(pdf, "KNOWLEDGE SKILL",
              top: vertical_offset,
              left: SKILL_NAME_LEFT,
              font: FONT_MINOR_LABEL,
              width: 100,
              size: LABEL_SIZE,
              color: LABEL_COLOR
            )

            vertical_offset -= 5
            skill_count = character[:skills][:knowledge].length

            character[:skills][:knowledge].each_with_index do |s, i|
              render_skill(pdf, s, vertical_offset)
              vertical_offset -= SKILL_HEIGHT
              draw_skill_line(pdf, vertical_offset, dashed: i != skill_count - 1, is_last: skill_count - 1 == i)
            end
          end
        end

        def render_skill(pdf, skill, vertical_offset)
          write(pdf, skill[:name],
            top: vertical_offset,
            left: SKILL_NAME_LEFT,
            width: 100,
            size: 7.0,
            font: FONT_MINOR_TEXT
          )

          if(skill[:is_career])
            write(pdf, "X",
              top: vertical_offset,
              left: SKILL_CAREER_LEFT,
              width: SKILL_RANK_LEFT - SKILL_CAREER_LEFT,
              align: :center,
              size: 7.0,
              font: FONT_MAJOR_TEXT
            )
          end

          write(pdf, skill[:rank],
            top: vertical_offset,
            left: SKILL_RANK_LEFT,
            width: SKILL_ROLL_LEFT - SKILL_RANK_LEFT,
            align: :center,
            size: 7.0,
            font: FONT_MINOR_TEXT
          )

          draw_dice(pdf,
            top: vertical_offset - 0.5,
            right: full_width - 2,
            proficiency: (skill[:proficiency] || 0).to_i,
            ability: skill[:ability].to_i
          )
        end

        def draw_skill_line(pdf, vertical_offset, opts)
          top = vertical_offset + 2.2
          line_height = 2.6
          length = opts[:is_last] ? line_height : line_height * 2

          draw_line(pdf,
            opts.merge(
              top: top,
              left: 0 + LINE_WIDTH / 2.0,
              length: full_width - LINE_WIDTH / 2.0,
              stroke_color: COLOR_TABLE_FOREGROUND,
              direction: :horizontal,
              line_width: 0.2
            )
          )

          draw_line(pdf,
            top: top + line_height,
            left: SKILL_CAREER_LEFT - 0.5,
            length: length,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: top + line_height,
            left: SKILL_RANK_LEFT,
            length: length,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: top + line_height,
            left: SKILL_ROLL_LEFT,
            length: length,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )
        end
      end
    end
  end
end
