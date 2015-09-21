module Starkiller
  module Components
    module Characteristics
      include Starkiller::Component

      BOX_SIZE = 52
      LABEL_HEIGHT = 11
      LABEL_PADDING = 2
      PADDING = 6

      class << self
        def render(pdf, character)
          within(pdf,
            top: DOCUMENT_TOP - 38,
            left: DOCUMENT_LEFT,
            width: BOX_SIZE + PADDING,
            height: BOX_SIZE * 6 + PADDING * 7
          ) do
            # Beige grouping decoration
            draw_rectangle(pdf,
              top: 0,
              left: 0,
              width: 15,
              height: full_height,
              fill_color: "c7b9a8"
            )

            characteristics = [
              {name: "BRAWN", value: character[:characteristic_brawn]},
              {name: "AGILITY", value: character[:characteristic_agility]},
              {name: "INTELLECT", value: character[:characteristic_intellect]},
              {name: "CUNNING", value: character[:characteristic_cunning]},
              {name: "WILLPOWER", value: character[:characteristic_willpower]},
              {name: "PRESENCE", value: character[:characteristic_presence]}
            ]

            characteristics.each_with_index { |c, i| draw_characteristic(pdf, c, i) }
          end
        end

        def draw_characteristic(pdf, characteristic, i)
          within(pdf,
            top: 0 - PADDING - (BOX_SIZE + PADDING) * i,
            left: PADDING,
            width: BOX_SIZE,
            height: BOX_SIZE
          ) do

            # Bounding box
            draw_rectangle(pdf,
              top: 0,
              left: 0,
              width: full_width,
              height: full_height,
              fill_color: "4A664B"
            )

            # Label background
            draw_rectangle(pdf,
              top: 0 - BOX_SIZE + LABEL_HEIGHT + LABEL_PADDING,
              left: LABEL_PADDING,
              width: full_width - LABEL_PADDING * 2,
              height: LABEL_HEIGHT,
              fill_color: "800000"
            )

            # Label
            write(pdf, characteristic[:name],
              top: 0 - BOX_SIZE + LABEL_HEIGHT - 0.5,
              left: LABEL_PADDING * 2,
              width: full_width - LABEL_PADDING * 4,
              align: :center,
              size: 8.0,
              font: FONT_HEADING,
              color: "ffffff",
              character_width: 0.8
            )

            # Characteristic Background
            pdf.fill_color = "ffffff"
            pdf.stroke_color = "000000"
            pdf.fill_and_stroke_circle([BOX_SIZE / 2.0, 0 - 19.5], 18)

            # Characteristic Value
            write(pdf, characteristic[:value],
              top: -10,
              left: 13,
              width: 25.44,
              font: FONT_MAJOR_NUMBER,
              align: :center,
              size: 28,
              color: "000000"
           )
          end
        end
      end
    end
  end
end
