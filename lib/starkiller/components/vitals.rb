module Starkiller
  module Components
    module Vitals
      include Starkiller::Component
      extend Starkiller::Dice

      HORIZONTAL_BUFFER = 10
      BORDER_WIDTH = 0.6
      BOX_WIDTH = 55
      BOX_HEIGHT = 37
      BOX_SPACING = 22.4
      BOTTOM_LABEL_BUFFER = 3

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

            left = BOTTOM_LABEL_BUFFER

            draw_soak(pdf, left: left, soak: character[:soak])

            left += BOX_WIDTH + BOX_SPACING

            draw_split_vital(pdf,
              title: "WOUNDS",
              value_left: character[:wounds_threshold],
              value_right: character[:wounds_current],
              label_left: "THRESHOLD",
              label_right: "CURRENT",
              placeholder_right: true,
              left: left
            )

            left += BOX_WIDTH + BOX_SPACING + BOTTOM_LABEL_BUFFER

            draw_split_vital(pdf,
              title: "STRAIN",
              left: left,
              value_left: character[:strain_threshold],
              value_right: character[:strain_current],
              label_left: "THRESHOLD",
              label_right: "CURRENT",
              placeholder_right: true
            )

            left += BOX_WIDTH + BOX_SPACING + BOTTOM_LABEL_BUFFER

            draw_split_vital(pdf,
              title: "DEFENSE",
              value_left: character[:defense_ranged],
              value_right: character[:defense_melee],
              label_left: "RANGED",
              label_right: "MELEE",
              left: left
            )
          end
        end

        def draw_soak(pdf, opts)
          left = opts[:left]

          draw_rectangle(pdf,
            top: 0,
            left: left,
            fill_color: "ffffff",
            stroke_color: "000000",
            line_width: BORDER_WIDTH,
            width: BOX_WIDTH,
            height: 37
          )

          draw_rectangle(pdf,
            top: 0 - BORDER_WIDTH / 2.0,
            left: left + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: BOX_WIDTH - BORDER_WIDTH,
            height: 13
          )

          write(pdf, "SOAK",
            top: -3.5,
            left: left + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: BOX_WIDTH - BORDER_WIDTH,
            align: :center,
            size: 8.0,
            font: FONT_HEADING,
            color: "ffffff",
            character_width: 0.8
          )

          write(pdf, opts[:soak],
            top: -19,
            left: left + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: BOX_WIDTH - BORDER_WIDTH,
            align: :center,
            size: 15.0,
            font: FONT_MAJOR_NUMBER,
            color: "000000",
          )
        end

        def draw_split_vital(pdf, opts)
          left = opts[:left]
          left_box = left + 3

          draw_rectangle(pdf,
            top: -30,
            left: left,
            height: 15,
            width: left_box - left + BOX_WIDTH / 2.0,
            fill_color: "800000"
          )

          write(pdf, opts[:label_left],
            top: -39,
            left: left,
            width: left_box - left + BOX_WIDTH / 2.0,
            color: "ffffff",
            font: FONT_HEADING,
            size: 5,
            align: :center,
            character_width: 0.8
          )

          draw_rectangle(pdf,
            top: -30,
            left: left_box + BOX_WIDTH / 2.0,
            height: 15,
            width: left_box - left + BOX_WIDTH / 2.0,
            fill_color: "2BBFDB"
          )

          write(pdf, opts[:label_right],
            top: -39,
            left: left_box + BOX_WIDTH / 2.0,
            width: left_box - left + BOX_WIDTH / 2.0,
            color: "000000",
            font: FONT_HEADING,
            size: 5,
            align: :center,
            character_width: 0.8
          )

          draw_rectangle(pdf,
            top: 0,
            left: left_box,
            fill_color: "ffffff",
            stroke_color: "000000",
            line_width: BORDER_WIDTH,
            width: BOX_WIDTH,
            height: 37
          )

          draw_rectangle(pdf,
            top: 0 - BORDER_WIDTH / 2.0,
            left: left_box + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: BOX_WIDTH - BORDER_WIDTH,
            height: 13
          )

          write(pdf, opts[:title],
            top: -3.5,
            left: left_box + BORDER_WIDTH / 2.0,
            fill_color: "324357",
            width: BOX_WIDTH - BORDER_WIDTH,
            align: :center,
            size: 8.0,
            font: FONT_HEADING,
            color: "ffffff",
            character_width: 0.8
          )

          draw_line(pdf,
            top: -13,
            left: left_box + BOX_WIDTH / 2.0,
            length: 37 - 13,
            direction: :vertical,
            line_width: 0.2
          )

          write(pdf, opts[:value_left],
            top: -19,
            left: left_box,
            width: BOX_WIDTH / 2.0,
            align: :center,
            size: 15.0,
            font: FONT_HEADING,
            color: "000000",
            character_width: 0.8
          )

          if(opts[:placeholder_right])
            write(pdf, "PRINTED @ #{opts[:label_right]} = #{opts[:value_right] || 0}",
              top: 5,
              left: left_box,
              width: BOX_WIDTH,
              align: :center,
              size: 5.0,
              font: FONT_HEADING,
              color: "999999",
              character_width: 0.8
            )
          else
            write(pdf, opts[:value_right],
              top: -19,
              left: left_box + BOX_WIDTH / 2.0,
              width: BOX_WIDTH / 2.0,
              align: :center,
              size: 15.0,
              font: FONT_HEADING,
              color: "000000",
              character_width: 0.8
            )
          end
        end
      end
    end
  end
end
