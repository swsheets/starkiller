module Starkiller
  module Components
    module AttackTable
      include Starkiller::Component
      extend Starkiller::Dice

      LABEL_SIZE = 5
      LABEL_COLOR = "aaaaaa"

      ATTACK_LABEL_OFFSET = 8
      ATTACK_LABEL_MARGIN_BOTTOM = 5
      ATTACK_RANGE_LEFT = 4
      ATTACK_SKILL_LEFT = 35
      ATTACK_NAME_LEFT = 85
      ATTACK_DAMAGE_RIGHT = 30
      ATTACK_CRITICAL_RIGHT = 15
      ATTACK_HEIGHT = 40

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

            vertical_offset = 0
            attack_count = character[:attacks].length

            character[:attacks].each_with_index do |a, i|
              render_attack(pdf, a, vertical_offset, is_last: attack_count - 1 == i)
              vertical_offset -= ATTACK_HEIGHT
            end
          end
        end

        def render_attack(pdf, attack, vertical_offset, opts)
          top = vertical_offset - ATTACK_LABEL_OFFSET
          values_top = top - ATTACK_LABEL_MARGIN_BOTTOM

          write(pdf, "RANGE",
            top: top,
            left: ATTACK_RANGE_LEFT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, attack[:range],
            top: values_top,
            left: ATTACK_RANGE_LEFT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: ATTACK_SKILL_LEFT - ATTACK_RANGE_LEFT
          )

          write(pdf, "SKILL",
            top: top,
            left: ATTACK_SKILL_LEFT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, attack[:skill],
            top: values_top,
            left: ATTACK_SKILL_LEFT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: 100
          )

          write(pdf, "WEAPON",
            top: top,
            left: ATTACK_NAME_LEFT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, attack[:name],
            top: values_top,
            left: ATTACK_NAME_LEFT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: full_width - ATTACK_NAME_LEFT - ATTACK_DAMAGE_RIGHT - 2
          )

          write(pdf, "DAM",
            top: top,
            left: full_width - ATTACK_DAMAGE_RIGHT,
            font: FONT_MINOR_LABEL,
            width: ATTACK_DAMAGE_RIGHT - ATTACK_CRITICAL_RIGHT - 2,
            align: :center,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, attack[:damage].to_s,
            top: values_top,
            left: full_width - ATTACK_DAMAGE_RIGHT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: ATTACK_DAMAGE_RIGHT - ATTACK_CRITICAL_RIGHT - 2,
            align: :center
          )

          write(pdf, "CRIT",
            top: top,
            left: full_width - ATTACK_CRITICAL_RIGHT,
            font: FONT_MINOR_LABEL,
            width: ATTACK_CRITICAL_RIGHT - 2,
            align: :center,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, attack[:critical].to_s,
            top: values_top,
            left: full_width - ATTACK_CRITICAL_RIGHT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: ATTACK_CRITICAL_RIGHT - 2,
            align: :center
          )

          second_row_top = top - 13

          draw_line(pdf,
            top: second_row_top,
            left: 0 + LINE_WIDTH / 2.0,
            length: full_width - LINE_WIDTH / 2.0,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :horizontal,
            line_width: 0.2,
            dashed: true
          )

          length = 5.2
          offset = 2

          draw_line(pdf,
            top: second_row_top + length / 2.0,
            left: ATTACK_SKILL_LEFT - offset,
            length: length,
            stroke_color: "000000",
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: second_row_top + length / 2.0,
            left: ATTACK_NAME_LEFT - offset,
            length: length,
            stroke_color: "000000",
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: second_row_top + length / 2.0,
            left: full_width - ATTACK_DAMAGE_RIGHT - offset,
            length: length,
            stroke_color: "000000",
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: second_row_top + length / 2.0,
            left: full_width - ATTACK_CRITICAL_RIGHT - offset,
            length: length,
            stroke_color: "000000",
            direction: :vertical,
            line_width: 0.2
          )
        end
      end
    end
  end
end
