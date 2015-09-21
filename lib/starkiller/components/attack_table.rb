module Starkiller
  module Components
    module AttackTable
      include Starkiller::Component
      extend Starkiller::Dice

      LABEL_SIZE = 5
      LABEL_COLOR = "999999"
      LABEL_OFFSET_LEFT = 2

      LINE_LENGTH = 2.6

      ATTACK_LABEL_OFFSET = 0
      ATTACK_LABEL_MARGIN_BOTTOM = 5
      ATTACK_RANGE_LEFT = 4
      ATTACK_SPECIALS_LEFT = ATTACK_RANGE_LEFT
      ATTACK_SKILL_LEFT = 35
      ATTACK_NAME_LEFT = 85
      ATTACK_ROLL_RIGHT = 44
      ATTACK_DAMAGE_RIGHT = 30
      ATTACK_CRITICAL_RIGHT = 15
      ATTACK_HEIGHT = 33.5

      MIN_ATTACKS = 8

      class << self
        def render(pdf, character)
          left = DOCUMENT_LEFT + Starkiller::Components::Characteristics::BOX_SIZE + Starkiller::Components::Characteristics::PADDING + 10

          within(pdf,
            top: DOCUMENT_TOP - 44 - 58,
            left: left,
            width: Starkiller::Components::SkillTable::COMPONENT_LEFT - left - 10,
            height: MIN_ATTACKS * ATTACK_HEIGHT + 4
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
              width: 46
            )

            vertical_offset = -8

            character[:attacks].each_with_index do |a, i|
              break if i >= MIN_ATTACKS
              render_attack(pdf, a, vertical_offset)
              vertical_offset -= ATTACK_HEIGHT
            end

            (MIN_ATTACKS - character[:attacks].length).times do
              render_attack(pdf, {}, vertical_offset, is_last: true)
              vertical_offset -= ATTACK_HEIGHT
            end
          end
        end

        def render_attack(pdf, attack, vertical_offset, opts = {})
          render_attack_first_row(pdf, attack, vertical_offset)
          render_attack_second_row(pdf, attack, vertical_offset - 17, opts)
        end

        def render_attack_first_row(pdf, attack, vertical_offset)
          top = vertical_offset

          write(pdf, "RANGE",
            top: top,
            left: ATTACK_RANGE_LEFT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, "SKILL",
            top: top,
            left: ATTACK_SKILL_LEFT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, "WEAPON",
            top: top,
            left: ATTACK_NAME_LEFT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, "DAM",
            top: top,
            left: full_width - ATTACK_DAMAGE_RIGHT,
            font: FONT_MINOR_LABEL,
            width: ATTACK_DAMAGE_RIGHT - ATTACK_CRITICAL_RIGHT,
            size: LABEL_SIZE,
            color: LABEL_COLOR,
            align: :center
          )

          write(pdf, "CRIT",
            top: top,
            left: full_width - ATTACK_CRITICAL_RIGHT,
            font: FONT_MINOR_LABEL,
            width: ATTACK_CRITICAL_RIGHT,
            align: :center,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          top = top - ATTACK_LABEL_MARGIN_BOTTOM

          write(pdf, attack[:range],
            top: top,
            left: ATTACK_RANGE_LEFT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: ATTACK_SKILL_LEFT - ATTACK_RANGE_LEFT
          )


          write(pdf, attack[:skill],
            top: top,
            left: ATTACK_SKILL_LEFT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: 100
          )

          write(pdf, attack[:name],
            top: top,
            left: ATTACK_NAME_LEFT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: full_width - ATTACK_NAME_LEFT - ATTACK_DAMAGE_RIGHT - 2
          )

          write(pdf, attack[:damage],
            top: top,
            left: full_width - ATTACK_DAMAGE_RIGHT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: ATTACK_DAMAGE_RIGHT - ATTACK_CRITICAL_RIGHT,
            align: :center
          )

          write(pdf, attack[:critical],
            top: top,
            left: full_width - ATTACK_CRITICAL_RIGHT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: ATTACK_CRITICAL_RIGHT,
            align: :center
          )

          top = top - 7.5

          draw_line(pdf,
            top: top,
            left: 0 + LINE_WIDTH / 2.0,
            length: full_width - LINE_WIDTH / 2.0,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :horizontal,
            line_width: 0.2,
            dashed: true
          )

          top = top + LINE_LENGTH

          draw_line(pdf,
            top: top,
            left: ATTACK_SKILL_LEFT - LABEL_OFFSET_LEFT,
            length: LINE_LENGTH * 2,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: top,
            left: ATTACK_NAME_LEFT - LABEL_OFFSET_LEFT,
            length: LINE_LENGTH * 2,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: top,
            left: full_width - ATTACK_DAMAGE_RIGHT,
            length: LINE_LENGTH * 2,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )

          draw_line(pdf,
            top: top,
            left: full_width - ATTACK_CRITICAL_RIGHT,
            length: LINE_LENGTH * 2,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )
        end

        def render_attack_second_row(pdf, attack, vertical_offset, opts)
          top = vertical_offset

          write(pdf, "SPECIALS",
            top: top,
            left: ATTACK_SPECIALS_LEFT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          write(pdf, "TOTAL ROLL",
            top: top,
            left: full_width - ATTACK_ROLL_RIGHT,
            font: FONT_MINOR_LABEL,
            width: 100,
            size: LABEL_SIZE,
            color: LABEL_COLOR
          )

          top = top - ATTACK_LABEL_MARGIN_BOTTOM

          write(pdf, attack[:specials],
            top: top,
            left: ATTACK_SPECIALS_LEFT,
            font: FONT_MINOR_TEXT,
            size: 7.0,
            width: full_width - ATTACK_SPECIALS_LEFT - ATTACK_ROLL_RIGHT - 2
          )

          draw_dice(pdf,
            top: top - 0.5,
            right: full_width - 2,
            proficiency: (attack[:proficiency] || 0).to_i,
            ability: attack[:ability].to_i
          )

          top = top - 7.5

          draw_line(pdf,
            top: top,
            left: 0 + LINE_WIDTH / 2.0,
            length: full_width - LINE_WIDTH / 2.0,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :horizontal,
            line_width: 0.2
          )

          top = top + LINE_LENGTH

          draw_line(pdf,
            top: top,
            left: full_width - ATTACK_ROLL_RIGHT,
            length: LINE_LENGTH,
            stroke_color: COLOR_TABLE_FOREGROUND,
            direction: :vertical,
            line_width: 0.2
          )
        end
      end
    end
  end
end
